//
//  LHQNavUIBaseVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHQNavigationBar.h"
#import "LHQNavigationVC.h"

NS_ASSUME_NONNULL_BEGIN

@class LHQNavUIBaseVC;

@protocol LHQNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LHQNavUIBaseVC *)navUIBaseVc;

@end

@interface LHQNavUIBaseVC : UIViewController <LHQNavigationBarDelegate,LHQNavigationBarDataSource,LHQNavUIBaseViewControllerDataSource>

/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@property (nonatomic, weak) LHQNavigationBar *lhq_navigationBar;

@end

NS_ASSUME_NONNULL_END
