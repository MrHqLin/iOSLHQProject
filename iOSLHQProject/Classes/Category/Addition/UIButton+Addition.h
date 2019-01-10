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

@end


