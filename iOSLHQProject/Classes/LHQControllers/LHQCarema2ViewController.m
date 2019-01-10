//
//  LHQCarema2ViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/27.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQCarema2ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LHQCameraTool.h"
#import "LHQCameraMaskingView.h"
#import "LHQRectView.h"
#import "LHQImageTransformViewController.h"
#import "LHQMaskingView.h"

@interface LHQCarema2ViewController () <LHQCaremaToolDelegate>

@property (nonatomic, strong) LHQCameraTool *caremaTool; // 捕捉工具
@property (nonatomic, strong) LHQRectView   *rectView; // 矩形边缘视图
@property (nonatomic, strong) NSTimer       *detectKeeper; // 边缘检测限时
@property (nonatomic, strong) UIView        *caremaView;
@property (nonatomic, assign) BOOL          enableDetectFrame; // 是否开启边缘检测
@property (nonatomic, strong) UIButton      *sceneBtn;
@property (nonatomic, strong) LHQMaskingView *maskingView; // 蒙层

@end

@implementation LHQCarema2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *caremaView = [[UIView alloc]initWithFrame:self.view.bounds];
    caremaView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:caremaView];
    self.caremaView = caremaView;
    
    LHQRectView *rectView = [[LHQRectView alloc]initWithFrame:caremaView.frame];
    rectView.hidden = NO;
    [self.view addSubview:rectView];
    self.rectView = rectView;
    
    // 蒙版
    self.maskingView = [[LHQMaskingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    self.maskingView.visibleArea = CGRectMake(30, 120, kScreenWidth-60, 400);
    [self.view addSubview:self.maskingView];
    
    LHQCameraTool *caremaTool = [[LHQCameraTool alloc]init];
    caremaTool.delegate = self;
    caremaTool.enableBorderDetection = YES;
    self.caremaTool = caremaTool;
    AVCaptureVideoPreviewLayer *previewlayer = [self.caremaTool getPreviewLayer];
    previewlayer.frame = caremaView.bounds;
    [caremaView.layer addSublayer:previewlayer];
    
    self.sceneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sceneBtn.frame = CGRectMake(0, 0, 70, 70);
    self.sceneBtn.lhq_centerX = self.view.lhq_centerX;
    self.sceneBtn.lhq_bottom = self.view.lhq_bottom - 70 + 30;
    [self.sceneBtn setImage:[UIImage imageNamed:@"carema_scene"] forState:UIControlStateNormal];
    [self.sceneBtn setImage:[UIImage imageNamed:@"carema_sure"] forState:UIControlStateSelected];
    [self.sceneBtn addTarget:self action:@selector(sceneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sceneBtn];
    
    [NSThread detachNewThreadSelector:@selector(startTimer) toTarget:self withObject:nil];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.caremaTool captureStartRunning];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.caremaTool captureStopRunning];

}

- (void)dealloc{
    [self.detectKeeper invalidate];
    self.detectKeeper = nil;
}

- (void)startTimer{
    self.detectKeeper =  [NSTimer scheduledTimerWithTimeInterval:0.65f
                                                          target:self
                                                        selector:@selector(enableBorderDetectFrame)
                                                        userInfo:nil
                                                         repeats:YES];
    
    [[NSRunLoop currentRunLoop] run];
}

- (void)enableBorderDetectFrame{
    self.enableDetectFrame = YES;
}

#pragma mark -- 拍摄
- (void)sceneClick:(UIButton *)sender{
    LHQWeak(self);
    [self.caremaTool captureImageWithCompletionHandler:^(UIImage *image, CIRectangleFeature *borderDetectFeature) {
        DLog(@"image = %@",image);
        LHQImageTransformViewController *transformVc = [[LHQImageTransformViewController alloc]init];
        transformVc.image = image;
        [weakself.navigationController pushViewController:transformVc animated:YES];
    }];
}

#pragma mark -- LHQCaremaToolDelegate
- (void)lhq_captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CIImage *image = [CIImage imageWithCVPixelBuffer:imageBuffer];
    
    CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
    [transform setValue:image forKey:kCIInputImageKey];
    NSValue *rotation = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(-90 * (M_PI/180))];
    
    [transform setValue:rotation forKey:@"inputTransform"];
    image = [transform outputImage];
    
    if (self.enableDetectFrame) {
    
        self.enableDetectFrame = NO;
        
        CIRectangleFeature *rectangleFeature = [self.caremaTool biggestRectangleInRectangles:[[self.caremaTool highAccuracyRectangleDetector] featuresInImage:image]];
        
        if(rectangleFeature){
            [self transfromRealRectWithImageRect:image.extent
                                         topLeft:rectangleFeature.topLeft
                                        topRight:rectangleFeature.topRight
                                      bottomLeft:rectangleFeature.bottomLeft
                                     bottomRight:rectangleFeature.bottomRight];
        }
        
        
        //更新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.rectView setNeedsDisplay];
        });
        
    }else{
        DLog(@"unable");
    }
    
        
    
}

// 坐标系转换
- (void)transfromRealRectWithImageRect:(CGRect)imageRect topLeft:(CGPoint)topLeft topRight:(CGPoint)topRight bottomLeft:(CGPoint)bottomLeft bottomRight:(CGPoint)bottomRight{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.rectView.hidden = NO;
        CGRect previewRect = self.caremaView.frame;
        CGFloat deltaX = CGRectGetWidth(previewRect)/CGRectGetWidth(imageRect);
        CGFloat deltaY = CGRectGetHeight(previewRect)/CGRectGetHeight(imageRect);
        
        //将坐标沿着y轴对称过去
        CGAffineTransform transform2 = CGAffineTransformMakeTranslation(0.f, CGRectGetHeight(previewRect));
        transform2 = CGAffineTransformScale(transform2, 1, -1);
        
        //按照cameraview的scale调整
        transform2 = CGAffineTransformScale(transform2, deltaX, deltaY);
        
        CGPoint points[4];
        points[0] = CGPointApplyAffineTransform(topLeft, transform2);
        points[1] = CGPointApplyAffineTransform(topRight, transform2);
        points[2] = CGPointApplyAffineTransform(bottomRight, transform2);
        points[3] = CGPointApplyAffineTransform(bottomLeft, transform2);
        
        
        [self.rectView drawWithPointsfirst:points[0]
                                    second:points[1]
                                     thrid:points[2]
                                     forth:points[3]];
    });
    
    
}


@end
