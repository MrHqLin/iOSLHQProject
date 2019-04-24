//
//  LHQPOPSpringAnimationViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

/*
 springBounciness 弹簧弹力,弹力越大振幅越大 [0 - 20]默认14
 springSpeed 速度,速度越大，动画结束越快 [0 - 20]
 dynamicsTension 弹簧的拉力
 dynamicsMass 物体的质量
 dynamicsFriction 摩擦力
 velocity 速率
 */

#import "LHQPOPSpringAnimationViewController.h"

@interface LHQPOPSpringAnimationViewController () <POPAnimationDelegate>

@property (nonatomic, strong) UIView *rectAngleView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation LHQPOPSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rectAngleView];
    [self.view addSubview:self.button];
    
}

- (void)animation{
    NSInteger height = CGRectGetHeight(self.view.frame);
    NSInteger widrh = CGRectGetWidth(self.view.bounds);
    CGFloat centerX  = arc4random() % widrh;
    CGFloat centerY = arc4random() % height;
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    // springBounciness 弹簧弹力,弹力越大振幅越大 [0 - 20]默认14
    spring.springBounciness = 16;
    // springSpeed 速度,速度越大，动画结束越快 [0 - 20]
    spring.springSpeed = 10;
    // dynamicsTension 弹簧的拉力
    spring.dynamicsTension = 214;
    // dynamicsMass 物体的质量
    spring.dynamicsMass = 1.0f;
    spring.delegate = self;
    [self.rectAngleView pop_addAnimation:spring forKey:@"center"];
    spring.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            DLog(@"finish");
        }
    };
    
}

#pragma mark - POPAnimationDelegate
/**
 @abstract Called on animation start.
 @param anim The relevant animation.
 */
- (void)pop_animationDidStart:(POPAnimation *)anim{
    DLog(@"动画开始");
}

/**
 @abstract Called when value meets or exceeds to value.
 @param anim The relevant animation.
 */
- (void)pop_animationDidReachToValue:(POPAnimation *)anim{
    DLog(@"将要达到toValue");
}

/**
 @abstract Called on animation stop.
 @param anim The relevant animation.
 @param finished Flag indicating finished state. Flag is true if the animation reached completion before being removed.
 */
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    DLog(@"动画结束");
}

/**
 @abstract Called each frame animation is applied.
 @param anim The relevant animation.
 */
- (void)pop_animationDidApply:(POPAnimation *)anim{
    DLog(@"动画执行过程一直调用");
}

#pragma mark - lazy
- (UIView *)rectAngleView
{
    if (!_rectAngleView)
    {
        _rectAngleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 50, 50)];
        _rectAngleView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1];
        _rectAngleView.layer.cornerRadius = _rectAngleView.frame.size.width/2;
        _rectAngleView.layer.masksToBounds = YES;
    }
    return _rectAngleView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"animation" forState:UIControlStateNormal];
        [_button sizeToFit];
        [_button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(animation) forControlEvents:UIControlEventTouchUpInside];
        _button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2 + 50);
    }
    return _button;
}


- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"POPSpringAnimation"];
}

@end
