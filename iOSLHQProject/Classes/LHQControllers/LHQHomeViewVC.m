//
//  LHQHomeViewVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQHomeViewVC.h"
#import "LHQAppdelegate.h"
#import "LHQMessageViewVC.h"
#import "LHQMeViewVC.h"
@interface LHQHomeViewVC ()

@end

@implementation LHQHomeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    LHQWordArrowItem *item01 = [LHQWordArrowItem itemWithTitle:@"item01" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        DLog(@"1");
        [self.navigationController pushViewController:[[LHQMeViewVC alloc]init] animated:YES];
    }];
    item01.destVc = [LHQMessageViewVC class];
    
    LHQWordArrowItem *item02 = [LHQWordArrowItem itemWithTitle:@"item02" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    LHQWordArrowItem *item03 = [LHQWordArrowItem itemWithTitle:@"item03" subTitle:@""];
    item03.destVc = [LHQMeViewVC class];
    
    LHQItemSection *section01 = [LHQItemSection sectionWithItems:@[item01,item02,item03] andHeaderTitle:@"" footerTitle:@"嘿嘿"];
    
    [self.sections addObject:section01];
    
    [MBProgressHUD showSuccess:@"成功" ToView:self.view];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LHQAppDelegate *appDelegate = (LHQAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.mainVc setPanEnabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    LHQAppDelegate *appDelegate = (LHQAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.mainVc setPanEnabled:NO];
}

#pragma mark - dataSource
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar
{
    return [self changeTitle:@"首页"];
}

- (UIImage *)lhqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LHQNavigationBar *)navigationBar
{
    [leftButton setTitle:@"菜单" forState:UIControlStateNormal];
    leftButton.lhq_width = AdaptedWidth(60);
    [leftButton setTitleColor:[UIColor RandomColor] forState:UIControlStateNormal];
    return nil;
}

#pragma mark - delegate
- (void)leftButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar
{
    LHQAppDelegate *appDelegate = (LHQAppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.mainVc.closed)
    {
        [appDelegate.mainVc openLeftView];
    }
    else
    {
        [appDelegate.mainVc closeLeftView];
    }
}

@end
