//
//  LHQMaskingView.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/26.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHQMaskingView : UIView

@property (nonatomic, strong) UIColor *maskingColor; // z蒙版颜色
@property (nonatomic, assign) CGRect  visibleArea; // 可视区域

@end

NS_ASSUME_NONNULL_END
