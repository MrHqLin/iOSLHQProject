//
//  LHQTimer.m
//  LHQWYMusic
//
//  Created by gaokun on 2018/5/2.
//  Copyright © 2018年 gaokun. All rights reserved.
//

#import "LHQTimer.h"

@interface LHQTimerTarget : NSObject

@property (nonatomic, weak) id      target;
@property (nonatomic, assign) SEL   selector;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation LHQTimerTarget

- (void)timeAction:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
    }else {
        [self.timer invalidate];
    }
}

@end

@implementation LHQTimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    LHQTimerTarget *timerTarget = [[LHQTimerTarget alloc] init];
    timerTarget.target   = target;
    timerTarget.selector = selector;
    timerTarget.timer    = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:timerTarget selector:@selector(timeAction:) userInfo:userInfo repeats:repeats];
    return timerTarget.timer;
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(LHQTimerBlock)block userInfo:(id)userInfo repeats:(BOOL)repeats {
    NSMutableArray *userInfoArr = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArr addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerBlock:) userInfo:[userInfoArr copy] repeats:repeats];
}

+ (void)timerBlock:(NSArray *)userInfo {
    LHQTimerBlock block = userInfo.firstObject;
    id info = nil;
    if (userInfo.count == 2) {
        info = userInfo[1];
    }
    
    !block ? : block(info);
}

@end
