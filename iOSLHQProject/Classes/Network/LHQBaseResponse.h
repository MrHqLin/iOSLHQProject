//
//  LMJBaseResponse.h
//  PLMMPRJK
//
//  Created by LIN on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestStatus) {
    RequestStatusSuccess = 1, // 请求成功
    RequestStatusFailed = 0, // 请求失败
    RequestStatusTokenExpired = 501, // token凭证过期
    RequestStatusOtherDeviceLogin = 502, // 若被另一台设备登录
};

@interface LHQBaseResponse : NSObject

/** 错误 */
@property (nonatomic, strong) NSError *error;

/** 错误提示 */
@property (nonatomic, copy) NSString *errorMsg;

/** 错误码 */
@property (assign, nonatomic) NSInteger statusCode;

/** 响应头 */
@property (nonatomic, strong) NSMutableDictionary *headers;

/** 响应体 */
@property (nonatomic, strong) id responseObject;

@end
