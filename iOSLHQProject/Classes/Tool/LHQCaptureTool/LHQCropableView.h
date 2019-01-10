//
//  LHQCropableView.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/4.
//  Copyright © 2019年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHQCropableView : UIView

@property (nonatomic, strong) UIColor *pointColor;
@property (nonatomic, strong) UIColor *lineColor;

- (id)initWithImageView:(UIImageView *)imageView;

- (NSArray *)getPoints;
- (UIImage *)deleteBackgroundOfImage:(UIImageView *)image;

- (void)addPointsAt:(NSArray *)points;
- (void)addPoints:(int)num;

+ (CGPoint)convertPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2;
+ (CGRect)scaleRespectAspectFromRect1:(CGRect)rect1 toRect2:(CGRect)rect2;

@end

