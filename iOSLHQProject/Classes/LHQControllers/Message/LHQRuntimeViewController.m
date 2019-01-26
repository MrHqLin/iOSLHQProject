//
//  LHQRuntimeViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/26.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQRuntimeViewController.h"
#import "LHQAlertViewService.h"

@interface LHQRuntimeViewController ()

@end

@implementation LHQRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // https://juejin.im/entry/58e700cca22b9d005890a1be
    
    LHQWeak(self);
    self.addItem([LHQWordItem itemWithTitle:@"获取类的信息" subTitle:@"关键字 class_get" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        
        // 类名
        NSString *className = [NSString stringWithFormat:@"class name: %s\n",class_getName([weakself class])];
        // 父类
        NSString *superClassName = [NSString stringWithFormat:@"super class name: %@\n",class_getSuperclass([weakself class])];
        // 是否是元类
        NSString *isMetaClass = [NSString stringWithFormat:@"is a meta class: %@\n",(class_isMetaClass([weakself class])? @"" : @"not")];
        // 元类是什么
        Class meta_class = objc_getMetaClass(class_getName([weakself class]));
        NSString *metaClass = [NSString stringWithFormat:@"%s's meta-class is %s\n", class_getName([weakself class]), class_getName(meta_class)];
        // 变量实例大小
        NSString *instanceSize = [NSString stringWithFormat:@"instance size: %zu\n", class_getInstanceSize([weakself class])];
        
        NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@",className,superClassName,isMetaClass,metaClass,instanceSize];
        [LHQAlertViewService showSystemAlertViewMessage:message title:@"获取类的信息"];
        
    }]);
    
}



@end
