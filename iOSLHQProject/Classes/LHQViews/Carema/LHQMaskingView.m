//
//  LHQMaskingView.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/26.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQMaskingView.h"

@implementation LHQMaskingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.maskingColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.visibleArea = CGRectMake(60, 100, frame.size.width - 2 * 60, frame.size.width - 2 * 60);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    
    CGSize sizeRetangle = self.visibleArea.size;
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.visibleArea.origin.y;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGFloat XRetangleLeft = self.visibleArea.origin.x;
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //非扫码区域半透明
    {
        //设置非识别区域颜色
        const CGFloat *components = CGColorGetComponents(self.maskingColor .CGColor);
        
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
        CGFloat alpa_notRecoginitonArea = components[3];
        
        CGContextSetRGBFillColor(context, red_notRecoginitonArea, green_notRecoginitonArea,
                                 blue_notRecoginitonArea, alpa_notRecoginitonArea);
        
        //填充矩形
        
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
        CGContextFillRect(context, rect);
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle);
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
}

@end
