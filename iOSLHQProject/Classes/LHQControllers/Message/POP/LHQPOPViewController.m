//
//  LHQPOPViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/28.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPOPViewController.h"
#import "LHQPOPBasicAnimationViewController.h"
#import "LHQPOPSpringAnimationViewController.h"
#import "LHQPOPDecayAnimationViewController.h"
#import "LHQPOPCustomAnimationViewController.h"
#import "LHQPOPGroupAnimationViewController.h"
#import "LHQGroupDemo1ViewController.h"
#import "LHQCycleDemo2ViewController.h"
#import "LHQTickDemo3ViewController.h"

@interface LHQPOPViewController ()

@end

@implementation LHQPOPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWeak(self);
    self.addItem([LHQWordItem itemWithTitle:@"POPBasicAnimation" subTitle:@"基础动画" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
    
        [weakself.navigationController pushViewController:[LHQPOPBasicAnimationViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"POPSpringAnimation" subTitle:@"弹簧动画" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQPOPSpringAnimationViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"POPDecayAnimation" subTitle:@"衰减动画" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQPOPDecayAnimationViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"POPCustomAnimation" subTitle:@"自定义动画" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQPOPCustomAnimationViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"POPGroupAnimation" subTitle:@"组合动画" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQPOPGroupAnimationViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"POPGroupAnimation 进度条" subTitle:@"组合动画-进度条" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQGroupDemo1ViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"圆环 进度条" subTitle:@"动画-进度条" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQCycleDemo2ViewController new] animated:YES];
    }]);
    
    self.addItem([LHQWordItem itemWithTitle:@"勾选动画" subTitle:@"打勾" itemOperation:^(NSIndexPath * _Nonnull indexPath){
        
        [weakself.navigationController pushViewController:[LHQTickDemo3ViewController new] animated:YES];
    }]);
    
    
    
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"POP动画引擎"];
}

@end
