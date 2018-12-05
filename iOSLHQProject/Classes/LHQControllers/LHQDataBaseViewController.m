//
//  LHQDataBaseViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQDataBaseViewController.h"
#import "DPDatabaseManager.h"

@interface LHQDataBaseViewController ()

@end

@implementation LHQDataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *name = [[NSArray arrayWithObjects:@"张三", @"李四", @"王五", @"赵六", @"鬼脚七", @"张小凡", @"碧瑶", @"周一仙", @"炼器师", nil] objectAtIndex:arc4random() % 8];
    NSUInteger age = arc4random() % 101 + 1;
    NSUInteger adult = arc4random() % 2;
    
    DemoModel *model = [[DemoModel alloc]init];
    model.userName = name;
    model.userAge = age;
    model.isAdult = adult == 1?YES:NO;
    
    //数据插入
    [[DPDatabaseManager sharedDBManager]insertDataWithModel:model withFileName:@"textDemo1"];

}



@end

@implementation DemoModel

@end
