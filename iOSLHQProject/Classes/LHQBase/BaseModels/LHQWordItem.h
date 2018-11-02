//
//  LHQWordItem.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHQWordItem : NSObject

// title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

// subTitle
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) UIFont *subTitleFont;
@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, assign) NSInteger subTitleNumberOfLines;

// 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName
@property (nonatomic, strong) id image;

// 设置cell的高度, 默认50 *
@property (assign, nonatomic) CGFloat cellHeight;

// 是否自定义这个cell , 如果自定义, 则在tableview返回默认的cell, 自己需要自定义cell返回
@property (assign, nonatomic, getter=isNeedCustom) BOOL needCustom;

// 点击操作
@property (nonatomic, copy) void(^itemOperation)(NSIndexPath *indexPath);

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;

@end

NS_ASSUME_NONNULL_END
