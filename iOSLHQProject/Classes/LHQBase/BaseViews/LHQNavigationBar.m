//
//  LHQNavigationBar.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQNavigationBar.h"

#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation LHQNavigationBar

#pragma mark - system
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupLHQNavigationBarUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.lhq_width, self.leftView.lhq_height);
    
    self.rightView.frame = CGRectMake(self.lhq_width - self.rightView.lhq_width, kStatusBarHeight, self.rightView.lhq_width, self.rightView.lhq_height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.lhq_height) * 0.5, MIN(self.lhq_width - MAX(self.leftView.lhq_width, self.rightView.lhq_width) * 2 - kViewMargin * 2, self.titleView.lhq_width), self.titleView.lhq_height);
    
    self.titleView.lhq_x = (self.lhq_width * 0.5 - self.titleView.lhq_width * 0.5);
    
    self.bottomBlackLineView.frame = CGRectMake(0, self.lhq_height, self.lhq_width, 0.5);
}

#pragma mark - setter
- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHaveTapGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            
            isHaveTapGes = YES;
            
            *stop = YES;
        }
    }];
    
    if (!isHaveTapGes) {
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        
        [titleView addGestureRecognizer:tapGes];
    }
    
    [self layoutIfNeeded];
}

- (void)setTitle:(NSMutableAttributedString *)title
{
    // 防止重复设置
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarTitleView:)] && [self.lhqDataSource lhqNavigationBarTitleView:self]) {
        return;
    }
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.lhq_width * 0.4, 44)];
    navTitleLabel.numberOfLines = 0;
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.lineBreakMode = NSLineBreakByClipping;
    
    self.titleView = navTitleLabel;
}

- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    
    [self addSubview:leftView];
    
    _leftView = leftView;
    
    if ([leftView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)leftView;
        
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
}

- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    
    [self addSubview:rightView];
    
    _rightView = rightView;
    
    if ([rightView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)rightView;
        
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    self.layer.contents = (id)backgroundImage.CGImage;
}

- (void)setLhqDataSource:(id<LHQNavigationBarDataSource>)lhqDataSource
{
    _lhqDataSource = lhqDataSource;
    
    [self setupDataSourceUI];
}

#pragma mark - getter

- (UIView *)bottomBlackLineView
{
    if(!_bottomBlackLineView)
    {
        CGFloat height = 0.5;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomBlackLineView;
}

#pragma mark - event
- (void)rightBtnClick:(UIButton *)btn
{
    if ([self.lhqDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        
        [self.lhqDelegate rightButtonEvent:btn navigationBar:self];
        
    }
    
}

- (void)leftBtnClick:(UIButton *)btn
{
    if ([self.lhqDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        
        [self.lhqDelegate leftButtonEvent:btn navigationBar:self];
        
    }
    
}

- (void)titleClick:(UIGestureRecognizer *)tap
{
    UILabel *view = (UILabel *)tap.view;
    if ([self.lhqDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
        
        [self.lhqDelegate titleClickEvent:view navigationBar:self];
    }
}

#pragma mark - custom

- (void)setupDataSourceUI
{
    // 高度
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarHeight:)]){
        
        self.lhq_size = CGSizeMake(kScreenWidth, [self.lhqDataSource lhqNavigationBarHeight:self]);
    }else{
        
        self.lhq_size = CGSizeMake(kScreenWidth, kDefaultNavBarHeight);
    }
    
    // 底部黑线
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarIsHideBottomLine:)]) {
        
        if ([self.lhqDataSource lhqNavigationBarIsHideBottomLine:self]) {
            self.bottomBlackLineView.hidden = YES;
        }
    }
    
    // 背景图
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarBackgroundImage:)]) {
        
        self.backgroundImage = [self.lhqDataSource lhqNavigationBarBackgroundImage:self];
    }
    
    // 背景色
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarBackgroundColor:)]) {
        
        self.backgroundColor = [self.lhqDataSource lhqNavigationBarBackgroundColor:self];
    }
    
    // 中间的View
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarTitleView:)]) {
        
        self.titleView = [self.lhqDataSource lhqNavigationBarTitleView:self];
        
    }else{
        
        self.title = [self.lhqDataSource lhqNavigationBarTitle:self];
    }
    
    // 导航left view
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarLeftView:)]) {
        
        self.leftView = [self.lhqDataSource lhqNavigationBarLeftView:self];
        
    }else if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarLeftButtonImage:navigationBar:)]){
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        
        UIImage *image = [self.lhqDataSource lhqNavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.leftView = btn;
    }
    
    // 导航right View
    if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarRightView:)]) {
        
        self.rightView = [self.lhqDataSource lhqNavigationBarRightView:self];
        
    }else if ([self.lhqDataSource respondsToSelector:@selector(lhqNavigationBarRightButtonImage:navigationBar:)]){
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        
        UIImage *image = [self.lhqDataSource lhqNavigationBarRightButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.rightView = btn;
    }
}

- (void)setupLHQNavigationBarUI{
    self.backgroundColor = [UIColor whiteColor];
}

@end
