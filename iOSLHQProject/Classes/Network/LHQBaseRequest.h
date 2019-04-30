//
//  LMJBaseRequest.h
//  PLMMPRJK
//
//  Created by LIN on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LHQBaseResponse;

@interface LHQBaseRequest : NSObject


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion;


- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion;

- (void)PUT:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LHQBaseResponse *response))completion;


@end
