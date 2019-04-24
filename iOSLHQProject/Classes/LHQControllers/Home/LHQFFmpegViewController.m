//
//  LHQFFmpegViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/13.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQFFmpegViewController.h"
#import "LHQFFmpegHelloWorldViewController.h"

@interface LHQFFmpegViewController ()

@end


@implementation LHQFFmpegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWordArrowItem *item01 = [LHQWordArrowItem itemWithTitle:@"FFmpeg-Hello World" subTitle:@""];
    item01.destVc = [LHQFFmpegHelloWorldViewController class];
    LHQItemSection *section01 = [LHQItemSection sectionWithItems:@[item01] andHeaderTitle:@"" footerTitle:@"嘿嘿"];
    
    [self.sections addObject:section01];
}


#pragma mark -- dataSource
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"FFmpeg音视频编码"];
}



@end
