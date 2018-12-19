//
//  RDSearchBar.h
//  ReadingApp
//
//  Created by LIN on 2018/11/9.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHQSearchBar : UISearchBar

//清除按钮是否隐藏
@property(nonatomic,assign)BOOL clearBtnHidden;

//placeHolder 是否居中 iOS11之前默认是居中的 iOS11之后居左
@property(nonatomic,assign)BOOL placeHolderCenter;

//placeHolder文字
@property(nonatomic,copy)NSString* placeHolderString;

//placeHolder字号 默认16 和输入框文字字号一样
@property(nonatomic,strong)UIFont* placeHolderStringFont;

//placeHolder文字颜色
@property(nonatomic,strong)UIColor* placeHolderStringColor;

//取消按钮文字  系统默认cancel,这里默认 取消
@property(nonatomic,copy)NSString* cancelBtnTitle;

//取消按钮文字颜色
@property(nonatomic,strong)UIColor* cancelBtnTitleColor;

//取消按钮文字大小
@property(nonatomic,strong)UIFont* cancelBtnTitleFont;

//圆角
@property(nonatomic,assign)CGFloat cornerRadius;

//边框颜色
@property(nonatomic,strong)UIColor* borderColor;

//边框宽度
@property(nonatomic,assign)CGFloat borderWidth;

//记录默认情况下的搜索图片偏移
@property(nonatomic,assign)UIOffset originPositionSearchOffSet;

//系统searchbar，如果search没有获得焦点，点击取消默认会获得焦点（而不会响应取消事件）
//cancelInputDisabled yes 直接响应取消事件
@property(nonatomic,assign)BOOL cancelInputDisabled;

@property (nonatomic, strong) UIColor *textFieldColor;

@property (nonatomic, assign) CGFloat textFieldHeight;

-(UITextField*)textField;

@end

NS_ASSUME_NONNULL_END
