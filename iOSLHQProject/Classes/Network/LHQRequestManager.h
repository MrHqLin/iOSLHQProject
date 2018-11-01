//
//  LHQRequestManager.h
//  PLMMPRJK
//
//  Created by LIN on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHQBaseResponse.h"
#import <AFNetworking.h>

typedef NSString LHQDataName;

typedef enum : NSInteger {
    // 自定义错误码
    LHQRequestManagerStatusCodeCustomDemo = -10000,
} LHQRequestManagerStatusCode;

typedef LHQBaseResponse *(^ResponseFormat)(LHQBaseResponse *response);

@interface LHQRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

// https 验证
@property (nonatomic, copy) NSString *cerFilePath;

- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LHQBaseResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(LHQBaseResponse *response))completion;

/*
  上传
   data 数据对应的二进制数据
   LHQDataName data对应的参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(NSDictionary<NSData *, LHQDataName *> *(^)(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *, LHQDataName *> *needFillDataDict))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(LHQBaseResponse *response))completion;

@end
