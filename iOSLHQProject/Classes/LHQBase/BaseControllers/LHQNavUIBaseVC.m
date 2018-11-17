//
//  LHQNavUIBaseVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQNavUIBaseVC.h"


@interface LHQNavUIBaseVC ()

@end

@implementation LHQNavUIBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWeak(self);
    [self.navigationItem addObserverBlockForKeyPath:LHQKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
    
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.lhq_navigationBar.lhq_width = self.view.lhq_width;
    [self.view bringSubviewToFront:self.lhq_navigationBar];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc{
    [self.navigationItem removeObserverBlocksForKeyPath:LHQKeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - LHQNavUIBaseViewControllerDataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LHQNavUIBaseVC *)navUIBaseVc{
    return YES;
}

#pragma mark - LHQNavigationBarDataSource
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:self.title ? : self.navigationItem.title];
}

- (UIColor *)lhqNavigationBarBackgroundColor:(LHQNavigationBar *)navigationBar{
    return [UIColor whiteColor];
}

- (CGFloat)lhqNavigationBarHeight:(LHQNavigationBar *)navigationBar{
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(LHQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}

#pragma mark - custom

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}

#pragma mark - getter
- (LHQNavigationBar *)lhq_navigationBar{
    if (!_lhq_navigationBar && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        LHQNavigationBar *navigationBar = [[LHQNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [self.view addSubview:navigationBar];
        _lhq_navigationBar = navigationBar;
        
        navigationBar.lhqDataSource = self;
        navigationBar.lhqDelegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }
    return _lhq_navigationBar;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.lhq_navigationBar.title = [self changeTitle:title];
}

@end
