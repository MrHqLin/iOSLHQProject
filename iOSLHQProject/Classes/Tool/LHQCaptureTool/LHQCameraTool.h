//
//  LHQCaremaTool.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/27.
//  Copyright © 2018年 water. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^CompletionHandler)(UIImage *image, CIRectangleFeature *borderDetectFeature);
@protocol LHQCaremaToolDelegate <NSObject>

// 边缘检测回调
- (void)lhq_captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;

@end

@interface LHQCameraTool : NSObject

@property (nonatomic, weak) id<LHQCaremaToolDelegate> delegate;
// 开启边缘检测
@property (nonatomic,assign,getter=isBorderDetectionEnabled) BOOL enableBorderDetection;
// 是否开启手电筒
@property (nonatomic,assign,getter=isTorchEnabled) BOOL enableTorch;
// 是否开启闪关灯
@property (nonatomic,assign,getter=isFlashEnabled) BOOL enableFlash;

// 获取预览层
- (AVCaptureVideoPreviewLayer *)getPreviewLayer;
// 开始捕捉
- (void)captureStartRunning;
// 停止捕捉
- (void)captureStopRunning;
// 高精度边缘检测
- (CIDetector *)highAccuracyRectangleDetector;
// 获取最大的矩形
- (CIRectangleFeature *)biggestRectangleInRectangles:(NSArray *)rectangles;
// 拍照动作
- (void)captureImageWithCompletionHandler:(CompletionHandler)completionHandler;

@end


