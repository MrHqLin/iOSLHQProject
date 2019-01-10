//
//  LHQNavigationBar.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LHQNavigationBar;

@protocol LHQNavigationBarDataSource <NSObject>

@optional

// 导航标题
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar;
// 导航背景
- (UIImage *)lhqNavigationBarBackgroundImage:(LHQNavigationBar *)navigationBar;
// 是否显示导航栏下黑线
- (BOOL)lhqNavigationBarIsHideBottomLine:(LHQNavigationBar *)navigationBar;
// 导航栏高度
- (CGFloat)lhqNavigationBarHeight:(LHQNavigationBar *)navigationBar;
// 导航栏颜色
- (UIColor *)lhqNavigationBarBackgroundColor:(LHQNavigationBar *)navigationBar;

// 导航栏左边视图
- (UIView *)lhqNavigationBarLeftView:(LHQNavigationBar *)navigationBar;
// 导航栏右边视图
- (UIView *)lhqNavigationBarRightView:(LHQNavigationBar *)navigationBar;
// 导航栏中间视图
- (UIView *)lhqNavigationBarTitleView:(LHQNavigationBar *)navigationBar;
// 导航栏左边按钮图
- (UIImage *)lhqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LHQNavigationBar *)navigationBar;
// 导航栏右边按钮图
- (UIImage *)lhqNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LHQNavigationBar *)naviagtionBar;


@end

@protocol LHQNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(LHQNavigationBar *)navigationBar;

@end

@interface LHQNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** <#digest#> */
@property (weak, nonatomic) UIView *titleView;

/** <#digest#> */
@property (weak, nonatomic) UIView *leftView;

/** <#digest#> */
@property (weak, nonatomic) UIView *rightView;

/** <#digest#> */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** <#digest#> */
@property (weak, nonatomic) id<LHQNavigationBarDataSource> lhqDataSource;

/** <#digest#> */
@property (weak, nonatomic) id<LHQNavigationBarDelegate> lhqDelegate;

/** <#digest#> */
@property (weak, nonatomic) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END
