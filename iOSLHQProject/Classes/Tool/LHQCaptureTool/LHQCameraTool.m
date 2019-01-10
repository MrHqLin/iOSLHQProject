//
//  LHQCaremaTool.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/27.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQCameraTool.h"
#import <CoreMotion/CoreMotion.h>

@interface LHQCameraTool () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession              *captureSession; // 捕捉会话
@property (nonatomic, strong) AVCaptureVideoPreviewLayer    *previewLayer; // 预览视图
@property (nonatomic, strong) AVCaptureDevice               *device; // 捕捉设备
@property (nonatomic, strong) AVCaptureVideoDataOutput      *output; // 输出流
@property (nonatomic, strong) AVCaptureStillImageOutput     *stillImageOutput; // 图片输出

@end

@implementation LHQCameraTool


- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setupSession];
    }
    return self;
}


#pragma mark -- 基本配置
- (void)setupSession{
    
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    session.sessionPreset = AVCaptureSessionPreset1920x1080;
    self.captureSession = session;
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer = previewLayer;
    
    AVCaptureDevice *device = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] firstObject];
    self.device = device;
    
    NSError *error = nil;
    AVCaptureDeviceInput *backFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (!error){
        if ([self.captureSession canAddInput:backFacingCameraDeviceInput]){
            [self.captureSession addInput:backFacingCameraDeviceInput];
        }
    }
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    [output setAlwaysDiscardsLateVideoFrames:YES];
    [output setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)}];
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [output setSampleBufferDelegate:self queue:queue];
    self.output = output;
    if([self.captureSession canAddOutput:self.output]){
        [self.captureSession addOutput:self.output];
    }
    
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [stillImageOutput setOutputSettings:outputSettings];
    self.stillImageOutput = stillImageOutput;
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [_stillImageOutput connections]){
        for (AVCaptureInputPort *port in [connection inputPorts]){
            if ([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection){
            break;
        }
    }
    [self.captureSession addOutput:self.stillImageOutput];


}

#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    // 开启边缘检测
    if (self.isBorderDetectionEnabled) {
        if ([_delegate respondsToSelector:@selector(lhq_captureOutput:didOutputSampleBuffer:fromConnection:)]) {
            [_delegate lhq_captureOutput:captureOutput didOutputSampleBuffer:sampleBuffer fromConnection:connection];
        }
    }
    
}

#pragma mark -- setter
// 设置手电筒
- (void)setEnableTorch:(BOOL)enableTorch{
    
    _enableTorch = enableTorch;
    
    AVCaptureDevice *device = self.device;
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        if (enableTorch)
        {
            [device setTorchMode:AVCaptureTorchModeOn];
        }
        else
        {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}
// 设置闪光灯
- (void)setEnableFlash:(BOOL)enableFlash{
    
    _enableFlash = enableFlash;
    AVCaptureDevice *device = self.device;
    if ([device hasTorch] && [device hasFlash])
    {
        [device lockForConfiguration:nil];
        if (enableFlash)
        {
            [device setTorchMode:AVCaptureTorchModeOn];
        }
        else
        {
            [device setFlashMode:AVCaptureFlashModeOff];
        }
        [device unlockForConfiguration];
    }
}


#pragma mark -- Public Method
- (AVCaptureVideoPreviewLayer *)getPreviewLayer{
    
    return self.previewLayer;
}

- (void)captureStartRunning{
    [self.captureSession startRunning];
}

- (void)captureStopRunning{
    [self.captureSession stopRunning];
}

// 拍照动作
- (void)captureImageWithCompletionHandler:(CompletionHandler)completionHandler{
   
    __weak typeof(self) weakSelf = self;

    //关闭闪光灯
    [self setEnableFlash:NO];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) break;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error){
        
        __strong typeof(self) strongSelf = weakSelf;
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        // 开启边缘检测
        if (strongSelf.isBorderDetectionEnabled)
        {
            
            CIImage *enhancedImage = [CIImage imageWithData:imageData];
            enhancedImage = [strongSelf filteredImageUsingContrastFilterOnImage:enhancedImage];
            // 判断边缘识别度阈值, 再对拍照后的进行边缘识别
            CIRectangleFeature *rectangleFeature;
            
            rectangleFeature = [strongSelf biggestRectangleInRectangles:[[self highAccuracyRectangleDetector] featuresInImage:enhancedImage]];
            if (rectangleFeature){
                enhancedImage = [strongSelf correctPerspectiveForImage:enhancedImage withFeatures:rectangleFeature];
            }
            
            // 获取拍照图片
            UIGraphicsBeginImageContext(CGSizeMake(enhancedImage.extent.size.height, enhancedImage.extent.size.width));
            [[UIImage imageWithCIImage:enhancedImage scale:1.0 orientation:UIImageOrientationRight] drawInRect:CGRectMake(0,0, enhancedImage.extent.size.height, enhancedImage.extent.size.width)];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            completionHandler(image, rectangleFeature);
        }
        // 未开启边缘检测
        else
        {
            completionHandler([UIImage imageWithData:imageData], nil);
        }
        
     }];
}

#pragma mark - 滤镜
- (CIImage *)filteredImageUsingEnhanceFilterOnImage:(CIImage *)image{
    return [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, image, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.14], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
}

- (CIImage *)filteredImageUsingContrastFilterOnImage:(CIImage *)image{
    return [CIFilter filterWithName:@"CIColorControls" withInputParameters:@{@"inputContrast":@(1.1),kCIInputImageKey:image}].outputImage;
}

// 将任意四边形转换成长方形
- (CIImage *)correctPerspectiveForImage:(CIImage *)image withFeatures:(CIRectangleFeature *)rectangleFeature
{
    NSMutableDictionary *rectangleCoordinates = [NSMutableDictionary new];
    rectangleCoordinates[@"inputTopLeft"] = [CIVector vectorWithCGPoint:rectangleFeature.topLeft];
    rectangleCoordinates[@"inputTopRight"] = [CIVector vectorWithCGPoint:rectangleFeature.topRight];
    rectangleCoordinates[@"inputBottomLeft"] = [CIVector vectorWithCGPoint:rectangleFeature.bottomLeft];
    rectangleCoordinates[@"inputBottomRight"] = [CIVector vectorWithCGPoint:rectangleFeature.bottomRight];
    return [image imageByApplyingFilter:@"CIPerspectiveCorrection" withInputParameters:rectangleCoordinates];
}


#pragma mark -- 矩形边缘检测
// 高精度检测
- (CIDetector *)highAccuracyRectangleDetector{
    static CIDetector *detector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      detector = [CIDetector detectorOfType:CIDetectorTypeRectangle context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
                  });
    return detector;
}

// 获取最大的矩形
- (CIRectangleFeature *)biggestRectangleInRectangles:(NSArray *)rectangles
{
    if (![rectangles count]) return nil;
    
    float halfPerimiterValue = 0;
    
    CIRectangleFeature *biggestRectangle = [rectangles firstObject];
    
    for (CIRectangleFeature *rect in rectangles)
    {
        CGPoint p1 = rect.topLeft;
        CGPoint p2 = rect.topRight;
        CGFloat width = hypotf(p1.x - p2.x, p1.y - p2.y);
        
        CGPoint p3 = rect.topLeft;
        CGPoint p4 = rect.bottomLeft;
        CGFloat height = hypotf(p3.x - p4.x, p3.y - p4.y);
        
        CGFloat currentHalfPerimiterValue = height + width;
        
        if (halfPerimiterValue < currentHalfPerimiterValue)
        {
            halfPerimiterValue = currentHalfPerimiterValue;
            biggestRectangle = rect;
        }
    }
    
    return biggestRectangle;
}

@end
