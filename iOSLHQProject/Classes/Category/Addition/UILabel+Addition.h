//
//  UILabel+Addition.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/10.
//  Copyright © 2019年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Addition)

+ (instancetype)lhq_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
