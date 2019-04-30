//
//  UIImage+Extension.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/4.
//  Copyright © 2019年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

// 旋转
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
// 图片压缩
+ (NSData *)compressWithImage:(UIImage *)sourceImage;
// 图片旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
// 绘制圆角
+ (UIImage *)drawCircleImageWithImage:(UIImage *)image size:(CGSize)size cornerRadius:(CGFloat)radius;

#pragma mark --- 生成二维码
+ (UIImage *)createQRCodeWithString:(NSString *)string imageWidth:(CGFloat)imageWidth;
- (UIImage *)createImageWithFilterCIImage:(CIImage *)image size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
