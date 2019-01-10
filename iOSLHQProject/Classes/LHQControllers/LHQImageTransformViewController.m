//
//  LHQImageTransformViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/4.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQImageTransformViewController.h"
#import "LHQCropableView.h"
#import "UIImage+Extension.h"

@interface LHQImageTransformViewController ()

@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) LHQCropableView   *pointsView;

@end

@implementation LHQImageTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片自由转换";
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.lhq_centerX = self.view.lhq_centerX;
    imageView.lhq_centerY = self.view.lhq_centerY;
//    imageView.lhq_y = 64;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = _image;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    NSArray *titles = @[@"旋转",@"编辑",@"确定",@"重置"];
    for (NSInteger index = 0; index < titles.count; index ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[index] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        button.frame = CGRectMake(10, 200 + 40*index, 50, 30);
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        [self.view addSubview:button];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self.view bringSubviewToFront:view];
        }
    }
}

#pragma mark -- button
- (void)tap:(UIButton *)sender{
    
    // 旋转
    if (sender.tag == 0)
    {
        if (self.pointsView) {
            [self.pointsView removeFromSuperview];
        }
        UIImage *image = [self.imageView.image imageRotatedByRadians:-M_PI_2];
        self.imageView.image = image;
    }
    // 编辑
    else if (sender.tag == 1)
    {
        if (self.pointsView) {
            [self.pointsView removeFromSuperview];
        }
        self.imageView.frame = [LHQCropableView scaleRespectAspectFromRect1:CGRectMake(0, 0, self.image.size.width, self.image.size.height) toRect2:self.imageView.frame];
        self.imageView.lhq_centerX = self.view.lhq_centerX;
        self.imageView.lhq_centerY = self.view.lhq_centerY;
        self.pointsView = [[LHQCropableView alloc] initWithImageView:self.imageView];
//        [self.pointsView addPoints:9];
        [self.pointsView addPointsAt:@[[NSValue valueWithCGPoint:CGPointMake(10, 10)],
                                       [NSValue valueWithCGPoint:CGPointMake(50, 10)],
                                       [NSValue valueWithCGPoint:CGPointMake(50, 50)],
                                       [NSValue valueWithCGPoint:CGPointMake(10, 50)]]];
        [self.view addSubview:self.pointsView];
        
    }
    // 编辑确定
    else if (sender.tag == 2)
    {
        if (self.pointsView) {
            self.imageView.image = [self.pointsView deleteBackgroundOfImage:self.imageView];
            [self.pointsView removeFromSuperview];
        }
        
    }
    // 重置
    else if (sender.tag == 3)
    {
        self.imageView.image = _image;

        if (self.pointsView) {
            [self.pointsView removeFromSuperview];
        }
    }
    
    
}


#pragma mark -- nav delegate
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LHQNavUIBaseVC *)navUIBaseVc{
    return NO;
}

@end
