//
//  LHQPOPCustomAnimationViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPOPCustomAnimationViewController.h"

@interface LHQPOPCustomAnimationViewController ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation LHQPOPCustomAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.countLabel];
    [self.view addSubview:self.button];
}

- (void)animation{
    POPBasicAnimation *basic = [POPBasicAnimation animation];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        // 告诉POP当前的属性值
        prop.readBlock = ^(id obj, CGFloat values[]) {
            DLog(@"1");
        };
        // 修改变化后的属性值
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
             [obj setText:[NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100]];
        };
        // 值越大block调用的次数越少 默认不去设置
        prop.threshold = 0.1;
    }];
    basic.property = prop;
    basic.fromValue = @(0);
    basic.toValue = @(3*60);
    basic.duration = 3 * 60;
    // 延迟一秒开始
    basic.beginTime = CACurrentMediaTime() + 1.0f;
    [self.countLabel pop_addAnimation:basic forKey:@"count"];
}

#pragma mark - lazy
- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 50, 130, 200, 50)];
        _countLabel.text = @"00:00:00";
        _countLabel.font = [UIFont systemFontOfSize:30];
    }
    return _countLabel;
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
    return [self changeTitle:@"POPCustomAnimation"];
}

@end
