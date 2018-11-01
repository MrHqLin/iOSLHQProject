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

// title
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar;
// background image
- (UIImage *)lhqNavigationBarBackgroundImage:(LHQNavigationBar *)navigationBar;
// bottom black line
- (BOOL)lhqNavigationBarIsHideBottomLine:(LHQNavigationBar *)navigationBar;
// bar height
- (CGFloat)lhqNavigationBarHeight:(LHQNavigationBar *)navigationBar;
// bar background color
- (UIColor *)lhqNavigationBarBackgroundColor:(LHQNavigationBar *)navigationBar;


// left view
- (UIView *)lhqNavigationBarLeftView:(LHQNavigationBar *)navigationBar;
// right view
- (UIView *)lhqNavigationBarRightView:(LHQNavigationBar *)navigationBar;
// Title view
- (UIView *)lhqNavigationBarTitleView:(LHQNavigationBar *)navigationBar;
// left button
- (UIImage *)lhqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LHQNavigationBar *)navigationBar;
// right button
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
