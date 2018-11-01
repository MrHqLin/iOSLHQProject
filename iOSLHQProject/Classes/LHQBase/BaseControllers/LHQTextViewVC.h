//
//  LHQTextViewVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQNavUIBaseVC.h"

@class LHQTextViewVC;

@protocol LHQTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(LHQTextViewVC *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(LHQTextViewVC *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(LHQTextViewVC *)textViewController;

@end

@protocol LHQTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(LHQTextViewVC *)textViewController inputViewDone:(id)inputView;
@end

NS_ASSUME_NONNULL_BEGIN

@interface LHQTextViewVC : LHQNavUIBaseVC <LHQTextViewControllerDataSource,LHQTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;

@end


#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (LHQTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface LHQTextViewControllerTextField : UITextField

@end

NS_ASSUME_NONNULL_END
