//
//  LHQFSAudioViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/4.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQFSAudioViewController.h"

@interface LHQFSAudioViewController ()

@property (nonatomic, strong) FSAudioStream *audioStream;

@end

@implementation LHQFSAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _audioStream = [[FSAudioStream alloc] init];
    // 播放失败的回调
    _audioStream.onFailure = ^(FSAudioStreamError error,NSString *description){
        NSLog(@"播放过程中发生错误，错误信息：%@",description);
    };
    // 播放完成的回调
    _audioStream.onCompletion=^(){
        NSLog(@"播放完成!");
    };
    // 设置音量
    [_audioStream setVolume:1];
    // 使用音频链接URL播放音频
    NSString *urlStr = @"http://116.62.145.127/group1/M00/03/ED/rBBmyFny9SGAZUamABeFGHfU_cU965.mp3";
    NSURL *url = [NSURL URLWithString:urlStr];
    [_audioStream playFromURL:url];
    
}



@end
