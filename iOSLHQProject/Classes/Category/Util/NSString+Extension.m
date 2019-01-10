//
//  NSString+Extension.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import "NSString+Extension.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Extension)

#pragma mark -- 加密
// md5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //CC_MD5(cStr, (uint32_t)(strlen(cStr)), result);
    CC_MD5( cStr, (uint32_t)self.length, result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
// Base64加密密码
- (NSString *)base64WithPassword{
    NSString *string = [NSString stringWithFormat:@"KL%@", [self base64EncodeString]];
    return string;
}

// 对字符串进行Base64编码，然后返回编码后的结果
- (NSString *)base64EncodeString{
    //1.先把字符串转换为二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}

// 对base64编码后的字符串进行解码
- (NSString *)base64DecodeString{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -- 文字设置
// 首行缩进及换行文字左对齐
+ (NSMutableAttributedString *)stringWithText:(NSString *)text
                                    textColor:(UIColor *)textColor
                                         font:(UIFont *)font
                                    lineSpace:(CGFloat)lineSpace
                          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                                    alignment:(NSTextAlignment)alignment{
    
    NSMutableAttributedString *attrStr0 = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr0 addAttribute:NSForegroundColorAttributeName
                     value:textColor
                     range:NSMakeRange(0, text.length)];
    [attrStr0 addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpace;// 字体的行间距
    paragraph.firstLineHeadIndent = firstLineHeadIndent;//首行缩进
    paragraph.alignment = alignment;
    
    [attrStr0 addAttribute:NSParagraphStyleAttributeName
                     value:paragraph
                     range:NSMakeRange(0, [text length])];
    
    return attrStr0;
}


// 限制输入emoji表情
+ (NSString *)disableEmoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

@end
