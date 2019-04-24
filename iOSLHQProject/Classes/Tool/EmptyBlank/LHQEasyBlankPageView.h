//
//  RDEasyBlankPageView.h
//  ReadingApp
//
//  Created by WaterWorld on 2018/11/21.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, EasyBlankPageViewType) {
    EasyBlankPageViewTypeNoData,
    EasyBlankPageViewTypeError,
    EasyBlankPageViewTypeLoading,
};

@interface LHQEasyBlankPageView : UIView

- (void)configWithType:(EasyBlankPageViewType)blankPageType hasData:(BOOL)hasData content:(NSString *)content reloadButtonBlock:(void(^)(UIButton *sender))block;
@end


@interface UIView (RDConfigBlank)
- (void)configBlankPage:(EasyBlankPageViewType)blankPageType hasData:(BOOL)hasData content:(NSString *)content reloadButtonBlock:(void(^)(id sender))block;

@end

