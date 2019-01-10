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
#import "LHQAudioViewController.h"
#import "LHQBaseRequest.h"
#import "LHQFSAudioViewController.h"
#import "LHQDataBaseViewController.h"
#import "LHQSearchBarViewController.h"
#import "LHQLottieViewController.h"
#import "LHQCameraViewController.h"
#import "LHQCarema2ViewController.h"
#import "LHQImageTransformViewController.h"

@interface LHQHomeViewVC ()

@end

@implementation LHQHomeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    LHQWordArrowItem *item01 = [LHQWordArrowItem itemWithTitle:@"录音" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        DLog(@"1");
        [self.navigationController pushViewController:[[LHQAudioViewController alloc]init] animated:YES];
    }];
    item01.destVc = [LHQMessageViewVC class];
    
    LHQWordArrowItem *item02 = [LHQWordArrowItem itemWithTitle:@"item02" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        
    }];
    item02.destVc = [LHQMeViewVC class];
    
    LHQWordArrowItem *item03 = [LHQWordArrowItem itemWithTitle:@"item03" subTitle:@""];
    item03.destVc = [LHQMeViewVC class];
    
    LHQWordArrowItem *item04 = [LHQWordArrowItem itemWithTitle:@"FSAudioStream" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        [self.navigationController pushViewController:[[LHQFSAudioViewController alloc]init] animated:YES];
    }];
    item04.destVc = [LHQFSAudioViewController class];
    
    LHQWordArrowItem *item05 = [LHQWordArrowItem itemWithTitle:@"数据库" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        [self.navigationController pushViewController:[[LHQDataBaseViewController alloc]init] animated:YES];
    }];
    item05.destVc = [LHQDataBaseViewController class];
    
    LHQWordArrowItem *item06 = [LHQWordArrowItem itemWithTitle:@"searchBar" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        [self.navigationController pushViewController:[[LHQSearchBarViewController alloc]init] animated:YES];
    }];
    item06.destVc = [LHQSearchBarViewController class];
    
    LHQWordArrowItem *item07 = [LHQWordArrowItem itemWithTitle:@"lottie动画" subTitle:@""];
    item07.destVc = [LHQLottieViewController class];
    
    LHQWordArrowItem *item08 = [LHQWordArrowItem itemWithTitle:@"自定义相机" subTitle:@""];
    item08.destVc = [LHQCameraViewController class];
    
    LHQWordArrowItem *item09 = [LHQWordArrowItem itemWithTitle:@"自定义相机的封装" subTitle:@""];
    item09.destVc = [LHQCarema2ViewController class];
    
    LHQWordArrowItem *item10 = [LHQWordArrowItem itemWithTitle:@"图片的自由变换" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        LHQImageTransformViewController *transformVc = [[LHQImageTransformViewController alloc]init];
        transformVc.image = [UIImage imageNamed:@"IMG_0152.JPG"];
        [self.navigationController pushViewController:transformVc animated:YES];
    }];
    item10.destVc = [LHQImageTransformViewController class];
    
    LHQItemSection *section01 = [LHQItemSection sectionWithItems:@[item01,item02,item03,item04,
                                                                   item05,item06,item07,item08,
                                                                   item09,item10] andHeaderTitle:@"" footerTitle:@"嘿嘿"];
    
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
