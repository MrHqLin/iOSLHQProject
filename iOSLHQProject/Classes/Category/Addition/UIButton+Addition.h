//
//  UIButton+Addition.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

+ (instancetype)lhq_textButton:(NSString *)title
                      fontSize:(CGFloat)fontSize
                   normalColor:(UIColor *)normalColor
                 selectedColor:(UIColor *)selectedColor;

+ (instancetype)lhq_textButton:(NSString *)title
                      fontSize:(CGFloat)fontSize
                   normalColor:(UIColor *)normalColor
                 selectedColor:(UIColor *)selectedColor
           backgroundImageName:(NSString *)backgroundImageName;

+ (instancetype)lhq_imageButton:(NSString *)imageName
            backgroundImageName:(NSString *)backgroundImageName;


/**
 图片在上，文字在下的格式，需要在button的frame确定之后才能有效使用
 
 @param interval 文字和图片的间隔
 */
- (void)imageUpAndTitleDownWithInterval:(CGFloat)interval;

/**
 给按钮添加边框
 
 @param borderColor 边框颜色
 @param borderwidth 边框的线条宽度pt
 */
- (void)addBorderWithBorderColor:(UIColor *)borderColor borderWidth:(float)borderwidth;

@end


