//
//  LHQCameraViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/20.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LHQMaskingView.h"
#import <CoreMotion/CoreMotion.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface LHQCameraViewController () <AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureSession              *session; // 捕捉会话
@property (nonatomic, strong) AVCaptureDeviceInput          *captureDeviceInput; // 输入设备
@property (nonatomic, strong) AVCaptureMovieFileOutput      *captureMovieFileOutput; // 视频输出流
@property (nonatomic, strong) AVCaptureVideoPreviewLayer    *previewLayer; // 图像预览层，实时显示捕获的图像

@property (nonatomic, strong) UIImageView                   *preview;
@property (nonatomic, strong) LHQMaskingView                *maskingView; // m灰色蒙版
@property (nonatomic, assign) BOOL                          isFocus; // 是否在对焦
@property (nonatomic, strong) UIImageView                   *focusCursor; // 聚焦光标
@property (nonatomic, strong) UIButton                      *sceneBtn; // 拍摄前 拍摄， 拍摄后 确定
@property (nonatomic, strong) UIButton                      *resetBtn; // 重新拍摄
@property (nonatomic, strong) NSURL                         *saveVideoUrl; // 记录需要保存视频的路径
@property (nonatomic, assign) UIBackgroundTaskIdentifier    backgroundTaskIdentifier; // 后台任务标识
@property (nonatomic, assign) UIBackgroundTaskIdentifier    lastBackgroundTaskIdentifier; // 上一个后台任务标识
@property (nonatomic, assign) NSInteger                     seconds; // //记录录制的时间 默认最大60秒
@property (nonatomic, strong) UIImage                       *takeImage; // 拍摄捕捉的图
@property (nonatomic, strong) UIImageView                   *takeImageView; // 拍摄后显示的图片

@property (nonatomic, strong) CMMotionManager               *cmmotionManager; // 获知设备方向

@end

@implementation LHQCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSession];
    [self setupCmmotionManager];
    [self setupUI];
    
    self.seconds = 0;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.session startRunning];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.session stopRunning];
}

#pragma mark -- UI
- (void)setupUI{
    
    self.sceneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sceneBtn.frame = CGRectMake(0, 0, 70, 70);
    self.sceneBtn.lhq_centerX = self.view.lhq_centerX;
    self.sceneBtn.lhq_bottom = self.view.lhq_bottom - 70 + 30;
    [self.sceneBtn setImage:[UIImage imageNamed:@"carema_scene"] forState:UIControlStateNormal];
    [self.sceneBtn setImage:[UIImage imageNamed:@"carema_sure"] forState:UIControlStateSelected];
    [self.sceneBtn addTarget:self action:@selector(sceneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sceneBtn addTarget:self action:@selector(touchDown:)forControlEvents: UIControlEventTouchDown];
    [self.view addSubview:self.sceneBtn];
    
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetBtn.frame = self.sceneBtn.bounds;
    self.resetBtn.lhq_centerX = self.view.lhq_centerX;
    self.resetBtn.lhq_bottom = self.view.lhq_bottom - 70 + 30;
    [self.resetBtn setImage:[UIImage imageNamed:@"carema_reset"] forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(sceneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetBtn];
    self.resetBtn.hidden = YES;
}

// 创建传感器
- (void)setupCmmotionManager{
    self.cmmotionManager = [[CMMotionManager alloc]init];
    self.cmmotionManager.deviceMotionUpdateInterval = 1/15.0;
    
    if (self.cmmotionManager.deviceMotionAvailable) {
        [self.cmmotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (accelerometerData.acceleration.x >= 0.75) {
                DLog(@"right");
            }
            else if (accelerometerData.acceleration.x < -0.75){
                DLog(@"left");
            }
            else if (accelerometerData.acceleration.y <= -0.75){
                DLog(@"Portrait");
            }
            else if (accelerometerData.acceleration.y > 0.75){
                DLog(@"dowm");
            }
            else if (accelerometerData.acceleration.z > 0.75){
                DLog(@"屏幕朝下");
            }
            else if (accelerometerData.acceleration.z <= -0.95){
                DLog(@"屏幕朝上");
            }
            DLog(@"z = %lf",accelerometerData.acceleration.z);
        }];
    }
}

#pragma mark -- 拍摄 / 重新拍摄 / 确定
- (void)sceneClick:(UIButton *)sender{
    
    if ([sender isEqual:self.sceneBtn])
    {
        if (sender.selected) { // 确定
            
        }else{ // 拍摄
            [self show];
//            [self endRecord];
            sender.selected = !sender.selected;
        }
    }
    // 重新拍摄
    else if ([sender isEqual:self.resetBtn])
    {
        [self dismiss];
        [self.session startRunning];
        if (!self.takeImageView.hidden) {
            self.takeImageView.hidden = YES;
        }
    }
    
}

- (void)show{
    
    CGFloat margin = kScreenWidth/3;
    self.resetBtn.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sceneBtn.centerX = 2*margin;
        self.resetBtn.centerX = margin;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.sceneBtn.centerX = self.view.lhq_centerX;
        self.resetBtn.centerX = self.view.lhq_centerX;
    } completion:^(BOOL finished) {
        self.resetBtn.hidden = YES;
        self.sceneBtn.selected = !self.sceneBtn.selected;
    }];
}

- (void)touchDown:(UIButton *)sender{
    [self startRecord];
}

// 开始录制
- (void)startRecord{
    //根据设备输出获得连接
    AVCaptureConnection *connection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeAudio];
    //根据连接取得设备输出的数据
    if (![self.captureMovieFileOutput isRecording]) {
        //如果支持多任务则开始多任务
        if ([[UIDevice currentDevice] isMultitaskingSupported]) {
            self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        }
        if (self.saveVideoUrl) {
            [[NSFileManager defaultManager] removeItemAtURL:self.saveVideoUrl error:nil];
        }
        //预览图层和视频方向保持一致
        connection.videoOrientation = [self.previewLayer connection].videoOrientation;
        NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"];
        NSLog(@"save path is :%@",outputFielPath);
        NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
        NSLog(@"fileUrl:%@",fileUrl);
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
    } else {
        [self.captureMovieFileOutput stopRecording];
    }
}

// 停止录制
- (void)endRecord {
    [self.captureMovieFileOutput stopRecording];//停止录制
}

#pragma mark -- AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections{
   [self performSelector:@selector(onStartTranscribe:) withObject:fileURL afterDelay:1.0];
    
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error{
    [self show];
    self.lastBackgroundTaskIdentifier = self.backgroundTaskIdentifier;
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    [self.session stopRunning];
    [self videoHandlePhoto:outputFileURL];
}

- (void)onStartTranscribe:(NSURL *)fileURL {
    if ([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];
    }
}

- (void)videoHandlePhoto:(NSURL *)url {
    AVURLAsset *urlSet = [AVURLAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlSet];
    imageGenerator.appliesPreferredTrackTransform = YES;    // 截图的时候调整到正确的方向
    NSError *error = nil;
    CMTime time = CMTimeMake(0,30);//缩略图创建时间 CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要获取某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actucalTime; //缩略图实际生成的时间
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actucalTime error:&error];
    if (error) {
        DLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    CMTimeShow(actucalTime);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    if (image) {
        DLog(@"视频截取成功");
    } else {
        DLog(@"视频截取失败");
    }
    
    
    self.takeImage = image;//[UIImage imageWithCGImage:cgImage];
    
    [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
    
    if (!self.takeImageView) {
        self.takeImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        [self.preview addSubview:self.takeImageView];
    }
    self.takeImageView.hidden = NO;
    self.takeImageView.image = self.takeImage;
}
#pragma mark - -相关配置
- (void)setupSession{
    //初始化会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc] init];
    //设置分辨率 (设备支持的最高分辨率)
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.session.sessionPreset = AVCaptureSessionPresetHigh;
    }
    //取得后置摄像头
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice=[[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    //初始化输入设备
    NSError *error = nil;
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        DLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //添加音频
    error = nil;
    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        DLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //输出对象
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];//视频输出
    
    //将输入设备添加到会话
    if ([self.session canAddInput:self.captureDeviceInput]) {
        [self.session addInput:self.captureDeviceInput];
        [self.session addInput:audioCaptureDeviceInput];
        //设置视频防抖
        AVCaptureConnection *connection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([connection isVideoStabilizationSupported]) {
            connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeCinematic;
        }
    }
    
    //将输出设备添加到会话 (刚开始 是照片为输出对象)
    if ([self.session canAddOutput:self.captureMovieFileOutput]) {
        [self.session addOutput:self.captureMovieFileOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    //输出流视图
    self.preview  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    [self.view addSubview:self.preview];
    
    // 蒙版
    self.maskingView = [[LHQMaskingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    self.maskingView.visibleArea = CGRectMake(30, 120, kScreenWidth-60, 400);
    [self.view addSubview:self.maskingView];
    
    // 设置预览层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    [self.preview.layer addSublayer:self.previewLayer];
    
    // 添加点按手势，点按时聚焦
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.maskingView addGestureRecognizer:tapGesture];
    
    self.focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.focusCursor.layer.borderColor = [UIColor orangeColor].CGColor;
    self.focusCursor.layer.borderWidth = 1;
    [self.view addSubview:self.focusCursor];
    self.focusCursor.alpha = 0;
}

#pragma mark -- 手势
// 添加点按手势，点按时聚焦
- (void)tapScreen:(UITapGestureRecognizer *)ges{
    if ([self.session isRunning]) {
        CGPoint point = [ges locationInView:self.preview];
        //将UI坐标转化为摄像头坐标
        CGPoint cameraPoint= [self.previewLayer captureDevicePointOfInterestForPoint:point];
        [self setFocusCursorWithPoint:point];
        [self focusWithMode:AVCaptureFocusModeContinuousAutoFocus exposureMode:AVCaptureExposureModeContinuousAutoExposure atPoint:cameraPoint];
    }
}


#pragma mark -- method
/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    if (!self.isFocus) {
        self.isFocus = YES;
        self.focusCursor.center=point;
        self.focusCursor.transform = CGAffineTransformMakeScale(1.25, 1.25);
        self.focusCursor.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            self.focusCursor.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(onHiddenFocusCurSorAction) withObject:nil afterDelay:0.5];
        }];
    }
}

- (void)onHiddenFocusCurSorAction {
    self.focusCursor.alpha=0;
    self.isFocus = NO;
}

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  设置聚焦点
 *
 *  @param point 聚焦点
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        //        if ([captureDevice isFocusPointOfInterestSupported]) {
        //            [captureDevice setFocusPointOfInterest:point];
        //        }
        //        if ([captureDevice isExposurePointOfInterestSupported]) {
        //            [captureDevice setExposurePointOfInterest:point];
        //        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        //自动白平衡
        if ([captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            [captureDevice setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }
        //自动根据环境条件开启闪光灯
        if ([captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [captureDevice setFlashMode:AVCaptureFlashModeAuto];
        }
        
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}


@end
