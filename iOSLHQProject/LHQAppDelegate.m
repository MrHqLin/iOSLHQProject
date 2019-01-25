//
//  AppDelegate.m
//  iOSLHQProject
//
//  Created by LIN on 2018/10/31.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQAppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LHQAudioPlayer.h"

@interface LHQAppDelegate ()
{
    UIBackgroundTaskIdentifier _bgTaskId;
}

@end

@implementation LHQAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    LHQLeftSlideVC *leftVc = [[LHQLeftSlideVC alloc] init];
    self.tabBarVc = [[LHQTabBarVC alloc]init];
    self.mainVc = [[LHQMainViewVC alloc]initWithLeftView:leftVc andMainView:self.tabBarVc];
    self.window.rootViewController = self.mainVc;
    
//    self.window.rootViewController = [[LHQTabBarVC alloc]init];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //开启后台处理多媒体事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    _bgTaskId = [LHQAppDelegate backgroundPlayerID:_bgTaskId];
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

// 后台音乐播放控制
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            DLog(@"play");
            break;
        case UIEventSubtypeRemoteControlPause:
            DLog(@"pause");
            [kPlayer stop];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            DLog(@"next");
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            DLog(@"previous");;
            break;
        default:
            break;
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
