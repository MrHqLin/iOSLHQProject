//
//  RDEasyBlankPageView.m
//  ReadingApp
//
//  Created by WaterWorld on 2018/11/21.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import "LHQEasyBlankPageView.h"

@interface LHQEasyBlankPageView ()

/** 加载按钮 */
@property (weak, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 提示 label */
@property (weak, nonatomic) UILabel *tipLabel;
/** 指示器 */
@property (weak, nonatomic) UIActivityIndicatorView *activityView;
/** 按钮点击 */
@property (nonatomic, copy) void(^reloadBlock)(UIButton *sender);

@end

@implementation LHQEasyBlankPageView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.backgroundColor = newSuperview.backgroundColor;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(frame.size.height * 0.18);
            make.centerX.offset(0);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.left.right.equalTo(self.imageView);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(AdaptedHeight(100));
        }];
        
        [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
            //            make.width.mas_equalTo(@94);
            make.height.mas_equalTo(44);
        }];
        
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        
    }
    return self;
}

- (void)configWithType:(EasyBlankPageViewType)blankPageType
               hasData:(BOOL)hasData
               content:(NSString *)content
     reloadButtonBlock:(void(^)(UIButton *sender))block
{
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.reloadBtn.hidden = YES;
    self.tipLabel.hidden = YES;
    self.imageView.hidden = YES;
    [self.activityView stopAnimating];
    self.reloadBlock = block;
    
    if (blankPageType == EasyBlankPageViewTypeNoData)
    {
        [self.imageView setImage:[UIImage imageNamed:@"banner_playlist_star"]];
        self.tipLabel.text = content;
        self.reloadBtn.hidden = YES;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
        [self.activityView stopAnimating];
        if (LHQIsEmpty(content)) {
            self.tipLabel.text = @"暂无数据";
        }
    }
    else if (blankPageType == EasyBlankPageViewTypeError)
    {
        [self.imageView setImage:[UIImage imageNamed:@"banner_playlist_star"]];
        self.tipLabel.text = content;
        self.reloadBtn.hidden = YES;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
        [self.activityView stopAnimating];
        if (LHQIsEmpty(content)) {
            self.tipLabel.text = @"网络未连接";
        }
    }
    else if (blankPageType == EasyBlankPageViewTypeLoading)
    {
        [self.activityView startAnimating];
        self.reloadBtn.hidden = YES;
        self.tipLabel.hidden = YES;
        self.imageView.hidden = YES;
    }
    
}

- (void)reloadClick:(UIButton *)btn{
    
    !self.reloadBlock ?: self.reloadBlock(btn);
}

- (UIButton *)reloadBtn{
    
    if(!_reloadBtn)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _reloadBtn = btn;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}

- (UIImageView *)imageView{
    
    if(!_imageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)tipLabel{
    
    if(!_tipLabel)
    {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipLabel = label;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.font = AdaptedFontSize(14);
    }
    return _tipLabel;
}

- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]init];
        [self addSubview:activityView];
        _activityView = activityView;
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityView.hidesWhenStopped = YES;
    }
    return _activityView;
}

@end

static void *BlankPageViewKey = &BlankPageViewKey;

@implementation UIView (RDConfigBlank)

- (void)setBlankPageView:(LHQEasyBlankPageView *)blankPageView{
    objc_setAssociatedObject(self, BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LHQEasyBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, BlankPageViewKey);
}

- (void)configBlankPage:(EasyBlankPageViewType)blankPageType hasData:(BOOL)hasData content:(NSString *)content reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[LHQEasyBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        
        [self.blankPageView configWithType:blankPageType hasData:NO content:content reloadButtonBlock:block];
    }
}

@end

