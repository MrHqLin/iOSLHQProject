//
//  NSString+Extension.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEUBase64.h"
#import "NSData+AES.h"

@interface NSString (Extension)

#pragma mark - 加密解密

#pragma mark - md5加密
// md5加密
- (NSString *)md5;

#pragma mark - base64

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAESData:(NSString*)string;
//将带密码的data转成string
+(NSString*)decryptAESData:(NSString *)string;

#pragma mark -- 文字设置
// 首行缩进及换行文字左对齐
+ (NSMutableAttributedString *)stringWithText:(NSString *)text
                                    textColor:(UIColor *)textColor
                                         font:(UIFont *)font
                                    lineSpace:(CGFloat)lineSpace
                          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                                    alignment:(NSTextAlignment)alignment;
// 限制输入emoji表情
+ (NSString *)disableEmoji:(NSString *)text;

#pragma mark - 绘制
- (void)drawInContext:(CGContextRef)context
         withPosition:(CGPoint)p
              andFont:(UIFont *)font
         andTextColor:(UIColor *)color
            andHeight:(float)height
             andWidth:(float)width;
- (void)drawInContext:(CGContextRef)context
         withPosition:(CGPoint)p
              andFont:(UIFont *)font
         andTextColor:(UIColor *)color
            andHeight:(float)height;

@end


