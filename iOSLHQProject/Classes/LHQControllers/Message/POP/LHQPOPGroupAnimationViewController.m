//
//  LHQPOPGroupAnimationViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPOPGroupAnimationViewController.h"

@interface LHQPOPGroupAnimationViewController ()

@property (nonatomic, strong) UIView *pushView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation LHQPOPGroupAnimationViewController
{
    BOOL _isOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.pushView];
    [_pushView addSubview:self.closeButton];
}


- (void)animation{
    
    if (_isOpen) {
        
    }
    _isOpen = YES;
    [self.pushView pop_removeAllAnimations];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spring.springBounciness = 6; // 弹力
    spring.springSpeed = 10; // 速度
    spring.fromValue = @-200;
    spring.toValue = @(self.view.center.y);
    
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.fromValue = @0.1;
    opacityAnim.toValue = @1.0;
    
    POPBasicAnimation *rorationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rorationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rorationAnim.beginTime = CACurrentMediaTime() + 0.1;
    rorationAnim.duration = 0.3;
    rorationAnim.fromValue = @0.6;
    rorationAnim.toValue = @(0);
    
    [self.pushView.layer pop_addAnimation:spring forKey:@"positonY"];
    [self.pushView.layer pop_addAnimation:opacityAnim forKey:@"opacity"];
    [self.pushView.layer pop_addAnimation:rorationAnim forKey:@"roration"];
}

#pragma mark - pushView
- (UIView *)pushView
{
    if (!_pushView)
    {
        _pushView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 230)];
        [_pushView.layer setCornerRadius:5.0f];
        _pushView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1.0 alpha:1.0];
        _pushView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, -200);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_pushView addGestureRecognizer:pan];
    }
    return _pushView;
}

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        _closeButton.center = CGPointMake(CGRectGetWidth(self.pushView.frame)/2, 210);
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"Animation" forState:UIControlStateNormal];
        [_button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_button sizeToFit];
        _button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame) - 60);
        [_button addTarget:self action:@selector(animation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"POPGroupAnimation"];
}

@end
