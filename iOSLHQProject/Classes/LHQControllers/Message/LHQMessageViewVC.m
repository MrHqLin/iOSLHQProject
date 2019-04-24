//
//  LHQMessageViewVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQMessageViewVC.h"
#import "LHQRuntimeViewController.h"
#import "LHQPOPViewController.h"
#import "LHQAsyncLayerViewController.h"

@interface LHQMessageViewVC ()

@end

@implementation LHQMessageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWordArrowItem *item0 = [LHQWordArrowItem itemWithTitle:@"Runtime理论学习" subTitle:@""];
    item0.destVc = [LHQRuntimeViewController class];
    LHQWordArrowItem *item1 = [LHQWordArrowItem itemWithTitle:@"POP动画引擎" subTitle:@""];
    item1.destVc = [LHQPOPViewController class];
    LHQWordArrowItem *item2 = [LHQWordArrowItem itemWithTitle:@"异步绘制" subTitle:@""];
    item2.destVc = [LHQAsyncLayerViewController class];
    
    LHQItemSection *section0 = [LHQItemSection sectionWithItems:@[item0,item1,item2]
                                                 andHeaderTitle:nil
                                                    footerTitle:nil];
    [self.sections addObject:section0];
}

#pragma mark - dataSource
- (UIImage *)lhqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LHQNavigationBar *)navigationBar{
    return nil;
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"理论学习"];
}

@end
