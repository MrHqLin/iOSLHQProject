//
//  LHQPOPDecayAnimationViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPOPDecayAnimationViewController.h"

@interface LHQPOPDecayAnimationViewController ()

@property (nonatomic, strong) UIView *roundView;

@end

@implementation LHQPOPDecayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     衰减动画主要是设置一个衰减值velocity来控制
     */
    
    [self.view addSubview:self.roundView];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan{
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            [self.roundView.layer pop_removeAllAnimations];
            
            CGPoint translation = [pan translationInView:self.view];
            
            CGPoint center = self.roundView.center;
            center.x += translation.x;
            center.y += translation.y;
            self.roundView.center = center;
            
            [pan setTranslation:CGPointZero inView:self.roundView];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            CGPoint velocity = [pan velocityInView:self.view];
            [self addDecayPositionAnimationWithVelocity:velocity];
            break;
        }
            
        default:
            break;
    }
}

// 添加减速动画
-(void)addDecayPositionAnimationWithVelocity:(CGPoint)velocity{
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    anim.velocity = [NSValue valueWithCGPoint:CGPointMake(velocity.x, velocity.y)];
    anim.deceleration = 0.998;
    [self.roundView.layer pop_addAnimation:anim forKey:@"AnimationPosition"];
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
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_roundView addGestureRecognizer:pan];
    }
    return _roundView;
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"POPDecayAnimation"];
}

@end
