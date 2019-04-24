//
//  LHQMeViewVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQMeViewVC.h"
#import "LHQPullMenuViewController.h"
#import "LHQDropMenuViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LHQMeViewVC () <AVCaptureAudioDataOutputSampleBufferDelegate>



@end

@implementation LHQMeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWordArrowItem *item01 = [LHQWordArrowItem itemWithTitle:@"仿微信收下下拉小程序" subTitle:@""];
    item01.destVc = [LHQPullMenuViewController class];
    
    LHQWordArrowItem *item02 = [LHQWordArrowItem itemWithTitle:@"自定义筛选菜单" subTitle:@""];
    item02.destVc = [LHQDropMenuViewController class];
    
    
    LHQItemSection *section01 = [LHQItemSection sectionWithItems:@[item01,item02] andHeaderTitle:@"" footerTitle:@"嘿嘿"];
    
    [self.sections addObject:section01];
    
}



@end
