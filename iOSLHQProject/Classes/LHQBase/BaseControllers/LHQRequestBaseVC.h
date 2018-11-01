//
//  LHQRequestBaseVc.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQTextViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@class LHQRequestBaseVC;
@protocol LHQRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(LHQRequestBaseVC *)inViewController;

@end

@interface LHQRequestBaseVC : LHQTextViewVC <LHQRequestBaseViewControllerDelegate>

- (void)showLoading;

- (void)dismissLoading;

@end

NS_ASSUME_NONNULL_END
