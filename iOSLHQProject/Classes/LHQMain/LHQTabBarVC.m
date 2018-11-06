//
//  LHQTabBarVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQTabBarVC.h"
#import "LHQHomeViewVC.h"
#import "LHQMessageViewVC.h"
#import "LHQMeViewVC.h"

@interface LHQTabBarVC () <UITabBarControllerDelegate>

@end

@implementation LHQTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllers];
    [self addTabBarItems];

}

- (void)addChildViewControllers
{
    LHQNavigationVC *homeNav = [[LHQNavigationVC alloc]initWithRootViewController:[[LHQHomeViewVC alloc]init]];
    LHQNavigationVC *messageNav = [[LHQNavigationVC alloc]initWithRootViewController:[[LHQMessageViewVC alloc]init]];
    LHQNavigationVC *meNav = [[LHQNavigationVC alloc]initWithRootViewController:[[LHQMeViewVC alloc]init]];
    self.viewControllers = @[homeNav,messageNav,meNav];
}


- (void)addTabBarItems
{
    NSDictionary *homeTabBarItemAttributes = @{@"TabBarItemTitle" : @"首页",
                                               @"TabBarItemImage" : @"tabBar_essence_icon",
                                               @"TabBarItemSelectedImage" : @"tabBar_essence_click_icon",
                                               };
    
    NSDictionary *messageTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"新帖",
                                                 @"TabBarItemImage" : @"tabBar_new_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_new_click_icon",
                                                 };
    
    NSDictionary *meTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"我",
                                                  @"TabBarItemImage" : @"tabBar_me_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_me_click_icon"
                                                  };
    
    NSArray<NSDictionary *> *tabBarItemsAttributes = @[
                                                       homeTabBarItemAttributes,
                                                       messageTabBarItemsAttributes,
                                                       meTabBarItemsAttributes
                                                       ];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    
//    self.tabBar.tintColor = [UIColor redColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    // 去掉顶部黑线
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.shadowImage = [UIImage new];
}

#pragma mark - delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

@end
