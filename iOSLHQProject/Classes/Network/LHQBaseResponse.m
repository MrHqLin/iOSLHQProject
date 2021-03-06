//
//  LMJBaseResponse.m
//  PLMMPRJK
//
//  Created by LIN on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LHQBaseResponse.h"


@implementation LHQBaseResponse


- (NSString *)description
{
    return [NSString stringWithFormat:@"\n状态码: %zd,\n错误: %@,\n响应头: %@,\n响应体: %@", self.statusCode, self.error, self.headers, self.responseObject];
}

- (void)setError:(NSError *)error
{
    _error = error;
    self.statusCode = error.code;
    self.errorMsg = error.localizedDescription;
}

- (void)setStatusCode:(NSInteger)statusCode
{
    _statusCode = statusCode;
    switch (_statusCode) {
        case RequestStatusSuccess:
        {
            
        }
            break;
        case RequestStatusFailed:
        {
            
        }
            break;
        case RequestStatusTokenExpired:
        {
            
        }
            break;
        case RequestStatusOtherDeviceLogin:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
