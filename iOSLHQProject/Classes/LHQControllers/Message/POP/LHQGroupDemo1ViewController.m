//
//  LHQGroupDemo1ViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQGroupDemo1ViewController.h"

@interface LHQGroupDemo1ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *roundView;

@end

@implementation LHQGroupDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.button];
    [self.view addSubview:self.roundView];
    
    
}

- (void)animation{
    [self.roundView pop_removeAllAnimations];
    // 重置视图
    for (CAShapeLayer *layer in self.roundView.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    _roundView.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 25, 150, 50, 50);
    
    // 白色进度条
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    // 颜色充满
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    // lineCap为线端点类型，值有三个类型，分别为kCALineCapButt 、kCALineCapRound 、kCALineCapSquare，默认值为Butt
    progressLayer.lineCap = kCALineCapRound;
    // lineJoin为线连接类型，其值也有三个类型，分别为kCALineJoinMiter、kCALineJoinRound、kCALineJoinBevel，默认值是Miter
    progressLayer.lineJoin = kCALineJoinRound;
    progressLayer.lineWidth = 26.0;
    // 代表路径的结束。在0和1之间的值沿路径长度进行线性插值。strokestart默认为0，strokeend默认为1
    progressLayer.strokeEnd = 0.0;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    // 起点
    [progressline moveToPoint:CGPointMake(25.0, 25.0)];
    // 终点
    [progressline addLineToPoint:CGPointMake(775.0, 25.0)];
    progressLayer.path = progressline.CGPath;
    
    [self.roundView.layer addSublayer:progressLayer];
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor whiteColor]];
//    gradientLayer.startPoint = CGPointMake(0, 1);
//    gradientLayer.endPoint = CGPointMake(1, 0);

    
    // 圆形->长方形->缩放->绘制进度条
    // 长方形
    POPSpringAnimation *boundsAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    boundsAnim.springSpeed = 6;
    boundsAnim.springBounciness = 10;
    boundsAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 800, 50)];
    boundsAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            UIGraphicsBeginImageContextWithOptions(self.roundView.frame.size, NO, 0.0);
            // 绘制动画
            POPBasicAnimation *progressAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            progressAnimation.duration = 1.0;
            progressAnimation.fromValue = @0.0;
            progressAnimation.toValue = @1.0;
            [progressLayer pop_addAnimation:progressAnimation forKey:@"AnimateBounds"];
            progressAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                if (finished) {
                    UIGraphicsEndImageContext();
                }
            };
        }
    };
    // 缩放
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.3, 0.3)];
    scaleAnimation.springBounciness = 5;
    scaleAnimation.springSpeed = 12;
    
    [self.roundView.layer pop_addAnimation:boundsAnim forKey:@"bounds"];
    [self.roundView.layer pop_addAnimation:scaleAnimation forKey:@"scale"];
}

#pragma mark - lazy
- (UIView *)roundView
{
    if (!_roundView)
    {
        _roundView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 25, 150, 50, 50)];
        _roundView.backgroundColor = [UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1];
        _roundView.layer.cornerRadius = _roundView.frame.size.width/2;
        _roundView.layer.masksToBounds = YES;
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
    return [self changeTitle:@"POPGroupAnimation 进度条"];
}

@end
