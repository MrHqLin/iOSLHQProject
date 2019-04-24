//
//  LHQPOPBasicAnimationViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPOPBasicAnimationViewController.h"

@interface LHQPOPBasicAnimationViewController ()

@property (nonatomic, strong) UIView *lhq_view;

@end

@implementation LHQPOPBasicAnimationViewController
{
    BOOL isScare;
    BOOL isAlpha;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lhq_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.lhq_view.center = self.view.center;
    self.lhq_view.backgroundColor = [UIColor orangeColor];
    self.lhq_view.layer.cornerRadius = 40;
    self.lhq_view.layer.masksToBounds = YES;
    [self.view addSubview:self.lhq_view];
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.lhq_view addGestureRecognizer:tapges];
}

- (void)tap:(UITapGestureRecognizer *)ges{

    // 对view的中心位置进行移动
    /*
    NSInteger width = CGRectGetWidth(self.view.frame);
    NSInteger height = CGRectGetHeight(self.view.frame);
    CGFloat centerX = arc4random() % width;
    CGFloat centerY = arc4random() % height;
     
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    basic.duration = 0.4;
    [self.lhq_view pop_addAnimation:basic forKey:@"centerMove"];
     */
    
    // 对View大小进行动画
    /*
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    if (isScare) {
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    }
    isScare = !isScare;
    basic.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self tap:nil];
    };
    [self.lhq_view pop_addAnimation:basic forKey:@"scareXY"];
     */
    
    // 对View透明度进行动画
    /**/
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    if (isAlpha) {
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(0.1, 0.1)];
    }
    isAlpha = !isAlpha;
    basic.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self tap:nil];
    };
    [self.lhq_view pop_addAnimation:basic forKey:@"alpha"];
     
    
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"POPBasicAnimation"];
}

@end
