//
//  UIView+Frame.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic) CGFloat lhq_x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat lhq_y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat lhq_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat lhq_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat lhq_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat lhq_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat lhq_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat lhq_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint lhq_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  lhq_size;        ///< Shortcut for frame.size.

@end

NS_ASSUME_NONNULL_END
