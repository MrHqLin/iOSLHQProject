//
//  API.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/4/30.
//  Copyright © 2019年 water. All rights reserved.
//

#import "APIService.h"

#define API [APIService shareInstance]

@implementation APIService

- (void)getdata{
    [API GET:@"" parameters:nil completion:^(LHQBaseResponse *response) {
        
    }];
}

static APIService *instance = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIService alloc]init];
    });
    return instance;
}

@end
