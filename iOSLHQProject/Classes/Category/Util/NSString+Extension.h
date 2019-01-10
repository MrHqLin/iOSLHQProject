//
//  NSString+Extension.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark -- 加密
// md5加密
- (NSString *)md5;
// Base64加密密码
- (NSString *)base64WithPassword;
// 对字符串进行Base64编码，然后返回编码后的结果
- (NSString *)base64EncodeString;
// 对base64编码后的字符串进行解码
- (NSString *)base64DecodeString;

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

@end


