//
//  UIView+Frame.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)lhq_x {
    return self.frame.origin.x;
}

- (void)setLhq_x:(CGFloat)lhq_x {
    CGRect frame = self.frame;
    frame.origin.x = lhq_x;
    self.frame = frame;
    
}

- (CGFloat)lhq_y {
    return self.frame.origin.y;
}

- (void)setLhq_y:(CGFloat)lhq_y {
    CGRect frame = self.frame;
    frame.origin.y = lhq_y;
    self.frame = frame;
}

- (CGFloat)lhq_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLhq_right:(CGFloat)lhq_right {
    CGRect frame = self.frame;
    frame.origin.x = lhq_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lhq_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLhq_bottom:(CGFloat)lhq_bottom {
    
    CGRect frame = self.frame;
    
    frame.origin.y = lhq_bottom - frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)lhq_width {
    return self.frame.size.width;
}

- (void)setLhq_width:(CGFloat)lhq_width {
    CGRect frame = self.frame;
    frame.size.width = lhq_width;
    self.frame = frame;
}

- (CGFloat)lhq_height {
    return self.frame.size.height;
}

- (void)setLhq_height:(CGFloat)lhq_height {
    CGRect frame = self.frame;
    frame.size.height = lhq_height;
    self.frame = frame;
}

- (CGFloat)lhq_centerX {
    return self.center.x;
}

- (void)setLhq_centerX:(CGFloat)lhq_centerX {
    self.center = CGPointMake(lhq_centerX, self.center.y);
}

- (CGFloat)lhq_centerY {
    return self.center.y;
}

- (void)setLhq_centerY:(CGFloat)lhq_centerY {
    self.center = CGPointMake(self.center.x, lhq_centerY);
}

- (CGPoint)lhq_origin {
    return self.frame.origin;
}

- (void)setLhq_origin:(CGPoint)lhq_origin {
    CGRect frame = self.frame;
    frame.origin = lhq_origin;
    self.frame = frame;
}

- (CGSize)lhq_size {
    return self.frame.size;
}

- (void)setLhq_size:(CGSize)lhq_size {
    CGRect frame = self.frame;
    frame.size = lhq_size;
    self.frame = frame;
}

@end
