//
//  LHQTickDemo3ViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/29.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQTickDemo3ViewController.h"

@interface LHQTickDemo3ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *roundView;

@end

@implementation LHQTickDemo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.button];
    [self.view addSubview:self.roundView];
}

- (void)animation{
    [_roundView.layer pop_removeAllAnimations];
    [_roundView.layer removeAllSublayers];
    
    
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    [bezier1 moveToPoint:CGPointMake(40, 100)];
    [bezier1 addLineToPoint:CGPointMake(60, 130)];
    [bezier1 addLineToPoint:CGPointMake(90, 40)];
    
    CAShapeLayer *tickLayer = [CAShapeLayer layer];
    tickLayer.path = bezier1.CGPath;
    tickLayer.strokeStart = 0;
    tickLayer.strokeEnd = 0;
    tickLayer.lineWidth = 5.0f;
    tickLayer.frame = _roundView.bounds;
    tickLayer.strokeColor = [UIColor orangeColor].CGColor;
    tickLayer.fillColor = [UIColor clearColor].CGColor;
    tickLayer.lineJoin = kCALineJoinBevel;
    
    [_roundView.layer addSublayer:tickLayer];
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 1.0f;
    anim.fromValue = @0.0;
    anim.toValue = @1.0;
    
    POPSpringAnimation *sprAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    sprAnim.springBounciness = 16;
    sprAnim.velocity = @5.0;
    sprAnim.fromValue = @0.0;
    sprAnim.toValue = @1.0;
    
    [tickLayer pop_addAnimation:anim forKey:@"tick"];
    [tickLayer pop_addAnimation:sprAnim forKey:@"sprTick"];
}


#pragma mark - lazy
- (UIView *)roundView
{
    if (!_roundView)
    {
        _roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _roundView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1];
        _roundView.center = self.view.center;
    }
    return _roundView;
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
    return [self changeTitle:@"勾选动画"];
}


@end
