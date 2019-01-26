//
//  LHQAudioViewController.m
//  iOSLHQProject
//
//  Created by hq.Lin on 2018/11/17.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQAudioViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LHQAudioViewController () <AVAudioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation LHQAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(audioPowerChange)
                                                userInfo:nil
                                                 repeats:YES];
    self.timer.fireDate = [NSDate distantFuture];//暂停定时器
    
    // 初始音频会话
    [self setAVAudioSession];
    // 初始化录音器
    [self initAudioRecorder];

}

#pragma mark -- base64 播放
- (IBAction)play:(id)sender {
    
    NSString *urlStr = [self getSaveFilePath];
    DLog(@"地址=%@",urlStr);
//    NSData *data = [NSData dataWithContentsOfFile:urlStr];
//    NSString *base64String = [data base64EncodedString];
//    DLog(@"base64=%@",base64String);
    
//    self.player.url = [NSURL URLWithString:base64String];
//    self.player.data = [NSData dataWithContentsOfFile:base64String];
//    [self.player play];
    
    NSString *base64String = [self encode:urlStr]; // 编码
    NSString *originString = [self dencode:base64String];
    
    NSError *error = nil;
//    NSData *audioData = [NSData dataWithBase64EncodedString:originString];
    NSURL *base64Url = [NSURL fileURLWithPath:originString];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:base64Url error:&error];
    if (error) {
        // Error Domain=NSOSStatusErrorDomain Code=1954115647 "(null)"
        NSLog(@"初始化音乐播放器失败");
        return;
    }
    player.numberOfLoops = 0;
    [player prepareToPlay];
    self.player = player;
    
    [self.player play];
}

// base64 编码
- (NSString *)encode:(NSString *)string
{
    // 先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return baseString;
}

// base64 解码
- (NSString *)dencode:(NSString *)base64String
{
    //NSData *base64data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

#pragma mark -- button click
- (IBAction)startTap:(UIButton *)sender {
    //录音
    if (![self.recorder isRecording]) {
        [self.recorder record];
        self.timer.fireDate = [NSDate distantPast];//恢复定时器
    }
}

- (IBAction)pauseTap:(UIButton *)sender {
    //录音暂停
    if ([self.recorder isRecording]) {
        [self.recorder pause];
        self.timer.fireDate = [NSDate distantFuture];//暂停定时器
    }
    
}

- (IBAction)finishTap:(UIButton *)sender {
    //录音停止
    [self.recorder stop];
    self.timer.fireDate = [NSDate distantFuture];//暂停定时器
    self.progressView.progress = 0.0;
}

/* 进度条模拟声波状态，每0.1秒执行一次 */
- (void)audioPowerChange{
    //更新测量值
    [self.recorder updateMeters];
    //取得第一个通道的音频，注意音频强度范围是-160.0到0
    float power = [self.recorder averagePowerForChannel:0];
    CGFloat progress = (1.0/160.0)*(power+160.0);
    self.progressView.progress = progress;
}

#pragma mark - AVAudioRecorderDelegate代理方法
/* 完成录音会调用 */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag
{
    //录音完成后自动播放录音
    [self initAudioPlayer];
    [self.player play];
    
}

#pragma mark -- config
/* 初始化录音器 */
- (void)initAudioRecorder{
    //创建URL
    NSString *filePath = [self getSaveFilePath];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    //设置录音格式
    [settings setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）, 采样率必须要设为11025才能使转化成mp3格式后不会失真
    [settings setObject:@(11025) forKey:AVSampleRateKey];
    //录音通道数  1 或 2 ，要转换成mp3格式必须为双通道
    [settings setObject:@(2) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [settings setObject:@(16) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [settings setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //录音的质量
    [settings setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    
    //创建录音器
    NSError *error = nil;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url
                                                            settings:settings
                                                               error:&error];
    if (error) {
        NSLog(@"初始化录音器失败");
        return;
    }
    recorder.delegate = self;//设置代理
    recorder.meteringEnabled = YES;//如果要监控声波，必须设为YES
    [recorder prepareToRecord];//为录音准备缓冲区
    self.recorder = recorder;
}


/* 设置音频会话支持录音和音乐播放 */
- (void)setAVAudioSession{
    //获取音频会话
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    //激活修改
    [audioSession setActive:YES error:NULL];
}

/* 初始化音频播放器 */
- (void)initAudioPlayer{
    NSString *filePath = [self getSaveFilePath];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                                   error:&error];
    if (error) {
        NSLog(@"初始化音乐播放器失败");
        return;
    }
    player.numberOfLoops = 0;
    [player prepareToPlay];
    self.player = player;
}



/* 获取录音存放路径 */
- (NSString *)getSaveFilePath{
    NSString *urlStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                           NSUserDomainMask,YES).firstObject;
    urlStr = [urlStr stringByAppendingPathComponent:@"recorder1.caf"];
    return urlStr;
}



@synthesize description;

@end
