//
//  RDAlertViewService.h
//  ReadingApp
//
//  Created by Duncan on 2018/11/9.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertViewBlock)(NSInteger buttonTag);

@interface LHQAlertViewService : NSObject

#pragma mark ------- UIAlertControllerStyleAlert -------
/**
 *  系统提示框 - 提示一些错误信息，如：输入手机号、密码格式不正确，或者输入为空等
 */
+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title;
+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title cancelTitle:(NSString * _Nullable)cancelTitle;

+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title cancelTitle:(NSString * _Nullable)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *_Nullable action))handler;

+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title okTitle:(NSString * _Nullable)okTitle cancelTitle:(NSString * _Nullable)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *_Nullable action))handler;

+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title okTitle:(NSString * _Nullable)okTitle cancelTitle:(NSString * _Nullable)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *_Nullable action))cancelHandler;

+ (void)showSystemAlertViewMessage:(NSString * _Nullable)message title:(NSString * _Nullable)title okTitle:(NSString * _Nullable)okTitle cancelTitle:(NSString * _Nullable)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))cancelHandler addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField * _Nullable textField))configurationHandler;

#pragma mark ------- UIAlertControllerStyleActionSheet -------
+ (void)showSystemSheetViewWithTitleArray:(NSArray * _Nullable)titleArray confirm:(AlertViewBlock _Nullable)confirm;

@end
