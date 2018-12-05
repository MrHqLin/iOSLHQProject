//
//  UIApplication+AppRootViewController.m
//  ReadingApp
//
//  Created by Duncan on 2018/11/9.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import "UIApplication+AppRootViewController.h"

@implementation UIApplication (AppRootViewController)

+ (UIViewController *)currentRootTopViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return [self findTopViewControllerWithCtl:topVC];
}

+ (UIViewController *)findTopViewControllerWithCtl:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)vc;
        UIViewController *ctl = tabVC.selectedViewController;
        
        if ([ctl isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)ctl).visibleViewController;
        } else {
            return vc.presentedViewController ? vc.presentedViewController : vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)vc).visibleViewController;
    } else {
        return vc.presentedViewController ? vc.presentedViewController : vc;
    }
}

@end
