//
//  LHQNavigationVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQNavigationVC.h"

@interface LHQNavigationVC ()

@end

@implementation LHQNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.hidden = YES;
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
