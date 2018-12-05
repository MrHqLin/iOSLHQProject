//
//  RDAlertViewService.m
//  ReadingApp
//
//  Created by Duncan on 2018/11/9.
//  Copyright © 2018年 WaterWorld. All rights reserved.
//

#import "LHQAlertViewService.h"
#import "UIApplication+AppRootViewController.h"

@interface LHQAlertViewService ()

@property (nonatomic, copy) AlertViewBlock block;

@end

@implementation LHQAlertViewService

#pragma mark ------- UIAlertControllerStyleAlert -------
+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title {
    [self showSystemAlertViewMessage:message title:title okTitle:@"确定" cancelTitle:nil OKHandler:nil cancelHandler:nil];
}

+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle {
    [self showSystemAlertViewMessage:message title:title okTitle:@"确定" cancelTitle:cancelTitle OKHandler:nil cancelHandler:nil];
}

+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *action))okHandler {
    [self showSystemAlertViewMessage:message title:title okTitle:@"确定" cancelTitle:cancelTitle OKHandler:okHandler cancelHandler:nil];
}

+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *action))okHandler {
    [self showSystemAlertViewMessage:message title:title okTitle:okTitle cancelTitle:cancelTitle OKHandler:okHandler cancelHandler:nil];
}

+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    if (okTitle) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:okHandler];
        [alertController addAction:okAction];
    }
    [[UIApplication currentRootTopViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (void)showSystemAlertViewMessage:(NSString *)message title:(NSString *)title okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle OKHandler:(void (^ __nullable)(UIAlertAction *action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:okHandler];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:configurationHandler];
    [[UIApplication currentRootTopViewController] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark ------- UIAlertControllerStyleActionSheet -------
+ (void)showSystemSheetViewWithTitleArray:(NSArray *)titleArray confirm:(AlertViewBlock)confirm {
    
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [cancelBtn setValue:k_Color_666666 forKey:@"titleTextColor"];
    [sheetController addAction:cancelBtn];
    
    if (titleArray.count > 0) {
        for (int i = 0; i < titleArray.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:titleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (confirm) {
                    confirm(i);
                }
            }];
//            [action setValue:k_Color_354261 forKey:@"titleTextColor"];
            [sheetController addAction:action];
        }
    }
    [[UIApplication currentRootTopViewController] presentViewController:sheetController animated:YES completion:nil];
}

@end
