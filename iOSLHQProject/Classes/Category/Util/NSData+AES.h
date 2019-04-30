//
//  NSData+AES.h
//  GeeLockApp
//
//  Created by 吴琼 on 2018/10/13.
//  Copyright © 2018年 吴琼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

/**
 加密

 @param key 加密的密钥
 @param iv 加密的向量
 @return 加密后的数据
 */
//- (NSData *)aes128_PKCS7EncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)aes128_CBC_PKCS7EncryptWithKey:(NSData *)key iv:(NSData *)iv;


/**
 解密

 @param key 解密的密钥
 @param iv 解密的向量
 @return 解密后的数据
 */
//- (NSData *)aes128_PKCS7DecryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)aes128_CBC_PKCS7DecryptWithKey:(NSData *)key iv:(NSData *)iv;


/**
 与后台通讯的加密的方法

 @param key 加密密钥
 @return 加密之后的数据
 */
- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密

/**
 与后台通讯的解密的方法

 @param key 解密的密钥
 @return 解密之后的数据
 */
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密

@end
