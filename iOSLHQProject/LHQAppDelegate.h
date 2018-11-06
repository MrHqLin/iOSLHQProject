//
//  AppDelegate.h
//  iOSLHQProject
//
//  Created by LIN on 2018/10/31.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHQMainViewVC.h"
#import "LHQLeftSlideVC.h"
#import "LHQTabBarVC.h"

@interface LHQAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LHQMainViewVC *mainVc;
@property (nonatomic, strong) LHQTabBarVC *tabBarVc;


@end

