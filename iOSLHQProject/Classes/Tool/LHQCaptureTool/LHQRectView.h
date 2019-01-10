//
//  LHQRectView.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/4.
//  Copyright © 2019年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHQRectView : UIView

@property (atomic) CGPoint point1;
@property (atomic) CGPoint point2;
@property (atomic) CGPoint point3;
@property (atomic) CGPoint point4;

- (void)drawWithPointsfirst:(CGPoint)point1 second:(CGPoint)point2 thrid:(CGPoint)point3 forth:(CGPoint)point4;

@end

NS_ASSUME_NONNULL_END
