//
//  LHQVioceBackViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/16.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQVioceBackViewController.h"
#import "LHQAudioPlayer.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LHQVioceBackViewController () <LHQAudioPlayerDelegate>

@end

@implementation LHQVioceBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kPlayer.delegate = self;
    // appdelegate 中的j进入后台的方法中需要设置
    /*
     // 应用程序转为后台（非激活）状态时被调用
     - (void)applicationWillResignActive:(UIApplication *)application {
     [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillResignActive object:nil];
     //开启后台处理多媒体事件
     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
     AVAudioSession *session=[AVAudioSession sharedInstance];
     [session setActive:YES error:nil];
     //后台播放
     [session setCategory:AVAudioSessionCategoryPlayback error:nil];
     //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
     _bgTaskId = [AppDelegate backgroundPlayerID:_bgTaskId];
     //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
     
     }
     
     + (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId {
     //设置并激活音频会话类别
     AVAudioSession *session = [AVAudioSession sharedInstance];
     [session setCategory:AVAudioSessionCategoryPlayback error:nil];
     [session setActive:YES error:nil];
     //允许应用程序接收远程控制
     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
     //设置后台任务ID
     UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
     newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
     if(newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid) {
     [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
     }
     return newTaskId;
     }

     */
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//    [self resignFirstResponder];
}


- (IBAction)playClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        kPlayer.playUrlStr = @"http://oss.iot.aispeech.com/dcmp/03/23/CiAB81u8Z7aABKarABF2kRWxfhw520.mp3";
        [kPlayer play];
        [self setLockScreenNowPlayingInfo];
    }else{
        [kPlayer stop];
    }
    
}

// 改变锁屏歌曲信息
- (void)setLockScreenNowPlayingInfo {
    
    //更新锁屏时的歌曲信息
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        // 歌曲名
        [dict setObject:@"学猫叫" forKey:MPMediaItemPropertyTitle];
        // 演唱者
        [dict setObject:@"林哥哥" forKey:MPMediaItemPropertyArtist];
        // 专辑名
        [dict setObject:@"专辑" forKey:MPMediaItemPropertyAlbumTitle];
        
        //专辑缩略图
        //        UIImage *newImage = [UIImage imageNamed:@"icon_test_test"];
        NSURL *url = [NSURL URLWithString:@"http://oss.iot.aispeech.com/dcmp/03/F2/CiAB81vlJMOAKiIOAAVRjLra6jE689.png"];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *ig = [[UIImage alloc]initWithData:imgData];
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:ig] forKey:MPMediaItemPropertyArtwork];
        
        //设置锁屏状态下屏幕显示播放音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
    
}




#pragma mark -- LHQAudioPlayerDelegate
// 播放器状态改变
- (void)lhqPlayer:(LHQAudioPlayer *)player statusChanged:(LHQAudioPlayerState)status{
    switch (status) {
        case LHQAudioPlayerStateLoading:{    // 加载中
            
        }
            break;
        case LHQAudioPlayerStateBuffering: { // 缓冲中
            
        }
            break;
        case LHQAudioPlayerStatePlaying: {   // 播放中
            
        }
            break;
        case LHQAudioPlayerStatePaused:{     // 暂停
            
        }
            break;
        case LHQAudioPlayerStateStoppedBy:{  // 主动停止
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
            break;
        case LHQAudioPlayerStateStopped:{    // 打断停止
            dispatch_async(dispatch_get_main_queue(), ^{
                [kPlayer play];
            });
        }
            break;
        case LHQAudioPlayerStateEnded: {     // 播放结束
            DLog(@"播放结束了");
            dispatch_async(dispatch_get_main_queue(), ^{
                [kPlayer stop];
            });
        }
            break;
        case LHQAudioPlayerStateError: {     // 播放出错
            DLog(@"播放出错了");
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
            break;
        default:
            break;
    }
}

// 播放时间（单位：毫秒)、总时间（单位：毫秒）、进度（播放时间 / 总时间）
- (void)lhqPlayer:(LHQAudioPlayer *)player currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime progress:(float)progress{
    //当前播放时间
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[MPNowPlayingInfoCenter defaultCenter] nowPlayingInfo]];
    // 歌曲总时长
    [dict setObject:@(totalTime/1000) forKey:MPMediaItemPropertyPlaybackDuration];
    // 当前播放时间
    [dict setObject:@(currentTime/1000) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    
}

// 总时间（单位：毫秒）
- (void)lhqPlayer:(LHQAudioPlayer *)player totalTime:(NSTimeInterval)totalTime{
    
}

// 缓冲进度
- (void)lhqPlayer:(LHQAudioPlayer *)player bufferProgress:(float)bufferProgress{
    
}

#pragma mark -- nav delegate

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"音乐后台播放锁屏设置"];
}

@end
