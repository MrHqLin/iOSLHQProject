//
//  LHQCycleDemo2ViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/29.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQCycleDemo2ViewController.h"

@interface LHQCycleDemo2ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *roundView;

@end

@implementation LHQCycleDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.roundView];
}

- (void)animation{
    [_roundView.layer pop_removeAllAnimations];
    // 重置视图
    for (CAShapeLayer *layer in self.roundView.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    
    CAShapeLayer *roundLayer = [CAShapeLayer layer];
    roundLayer.frame = CGRectMake(30, 30, 150, 150);
    roundLayer.lineWidth = 75;
    roundLayer.strokeColor = [UIColor redColor].CGColor;
    roundLayer.fillColor = [UIColor clearColor].CGColor;
    roundLayer.strokeStart = 0;
    roundLayer.strokeEnd = 0;
//    roundLayer.lineCap = kCALineCapRound;

    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(75, 75) radius:75/2 startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    
    roundLayer.path = bezier.CGPath;
    [_roundView.layer addSublayer:roundLayer];
    
//    CAShapeLayer *subLayer = [CAShapeLayer layer];
//    roundLayer.frame = CGRectMake(30, 30, 150, 150);
//    roundLayer.lineWidth = 5.0;
//    roundLayer.strokeColor = [UIColor greenColor].CGColor;
//    roundLayer.fillColor = [UIColor orangeColor].CGColor;
//    roundLayer.strokeStart = 0;
//    roundLayer.strokeEnd = 1.0;
//    roundLayer.lineCap = kCALineCapRound;
//
//    UIBezierPath *subbezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(75, 75) radius:75 startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
//
//    subLayer.path = subbezier.CGPath;
//    [_roundView.layer addSublayer:subLayer];
    
    
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 1.0f;
    anim.fromValue = @0.0;
    anim.toValue = @1.0;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            UIGraphicsEndImageContext();
            [self animation];
        }
    };
    
    [roundLayer pop_addAnimation:anim forKey:@"cycle"];
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
    return [self changeTitle:@"圆环进度条"];
}

@end
