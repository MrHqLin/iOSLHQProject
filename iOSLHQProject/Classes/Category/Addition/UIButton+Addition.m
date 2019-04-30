//
//  UIButton+Addition.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (instancetype)lhq_textButton:(NSString *)title
                      fontSize:(CGFloat)fontSize
                   normalColor:(UIColor *)normalColor
              selectedColor:(UIColor *)selectedColor {
    
    return [self lhq_textButton:title fontSize:fontSize normalColor:normalColor selectedColor:selectedColor backgroundImageName:nil];
}

+ (instancetype)lhq_textButton:(NSString *)title
                      fontSize:(CGFloat)fontSize
                   normalColor:(UIColor *)normalColor
                 selectedColor:(UIColor *)selectedColor
           backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }
    
    [button sizeToFit];
    
    return button;
}

+ (instancetype)lhq_imageButton:(NSString *)imageName
            backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

- (void)imageUpAndTitleDownWithInterval:(CGFloat)interval {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+interval, -self.imageView.frame.size.width, 0, 0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-self.imageView.frame.size.height/2, 0, 0, -self.titleLabel.frame.size.width)];
}

- (void)addBorderWithBorderColor:(UIColor *)borderColor borderWidth:(float)borderwidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderwidth;
}


@end
