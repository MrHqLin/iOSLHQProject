//
//  LHQDataBaseViewController.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQBaseViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHQDataBaseViewController : LHQBaseViewVC

@end


@interface DemoModel : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSUInteger userAge;

@property (nonatomic, assign) BOOL isAdult;

@end

NS_ASSUME_NONNULL_END
