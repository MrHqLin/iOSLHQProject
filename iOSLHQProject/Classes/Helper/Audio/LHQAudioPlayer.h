//
//  lhqAudioPlayer.h
//  lhqWYMusic
//
//  Created by gaokun on 2018/4/24.
//  Copyright © 2018年 gaokun. All rights reserved.
//  FreeStreamer中已经加入了开启后台持续播放任务、播放中断处理

#import <Foundation/Foundation.h>
#import <FreeStreamer/FSAudioStream.h>

// 播放器播放状态
typedef NS_ENUM(NSUInteger, LHQAudioPlayerState) {
    LHQAudioPlayerStateLoading,          // 加载中
    LHQAudioPlayerStateBuffering,        // 缓冲中
    LHQAudioPlayerStatePlaying,          // 播放
    LHQAudioPlayerStatePaused,           // 暂停
    LHQAudioPlayerStateStoppedBy,        // 停止（用户切换歌曲时调用）
    LHQAudioPlayerStateStopped,          // 停止（播放器主动发出：如播放被打断）
    LHQAudioPlayerStateEnded,            // 结束（播放完成）
    LHQAudioPlayerStateError             // 错误
};

// 播放器缓冲状态
typedef NS_ENUM(NSUInteger, LHQAudioBufferState) {
    LHQAudioBufferStateNone,
    LHQAudioBufferStateBuffering,
    LHQAudioBufferStateFinished
};

#define kPlayer [LHQAudioPlayer sharedInstance]

@class LHQAudioPlayer;

@protocol LHQAudioPlayerDelegate<NSObject>

// 播放器状态改变
- (void)lhqPlayer:(LHQAudioPlayer *)player statusChanged:(LHQAudioPlayerState)status;

// 播放时间（单位：毫秒)、总时间（单位：毫秒）、进度（播放时间 / 总时间）
- (void)lhqPlayer:(LHQAudioPlayer *)player currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime progress:(float)progress;

// 总时间（单位：毫秒）
- (void)lhqPlayer:(LHQAudioPlayer *)player totalTime:(NSTimeInterval)totalTime;

// 缓冲进度
- (void)lhqPlayer:(LHQAudioPlayer *)player bufferProgress:(float)bufferProgress;

@end

@interface LHQAudioPlayer : NSObject

/**
 代理
 */
@property (nonatomic, weak) id<LHQAudioPlayerDelegate> delegate;

/**
 播放地址（网络或本地）
 */
@property (nonatomic, copy) NSString *playUrlStr;

/**
 播放状态
 */
@property (nonatomic, assign) LHQAudioPlayerState    playerState;

/**
 缓冲状态
 */
@property (nonatomic, assign) LHQAudioBufferState    bufferState;

/**
 单例

 @return 播放器对象
 */
+ (instancetype)sharedInstance;

/**
 快进、快退

 @param progress 进度
 */
- (void)setPlayerProgress:(float)progress;

/**
 设置播放速率 0.5 - 2.0， 1.0是正常速率
 
 @param progress 速率
 */
- (void)setPlayerPlayRate:(float)playRate;

/**
 播放
 */
- (void)play;

/**
 从某个进度开始播放

 @param progress 进度
 */
- (void)playFromProgress:(float)progress;

/**
 暂停
 */
- (void)pause;

/**
 恢复（暂停后再次播放使用）
 */
- (void)resume;

/**
 停止
 */
- (void)stop;

@end
