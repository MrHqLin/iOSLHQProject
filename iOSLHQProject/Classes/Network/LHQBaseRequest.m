//
//  LHQBaseRequest.m
//  PLMMPRJK
//
//  Created by LIN on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LHQBaseRequest.h"
#import "LHQRequestManager.h"

@implementation LHQBaseRequest


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion
{
    
    LHQWeak(self);
    [[LHQRequestManager sharedManager] GET:URLString parameters:parameters completion:^(LHQBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        !completion ?: completion(response);
        
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion
{
    LHQWeak(self);
    [[LHQRequestManager sharedManager] POST:URLString parameters:parameters completion:^(LHQBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        !completion ?: completion(response);
        
    }];
}

- (void)PUT:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion
{
    LHQWeak(self);
    [[LHQRequestManager sharedManager] PUT:URLString parameters:parameters completion:^(LHQBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        !completion ?: completion(response);
        
    }];
}



@end
