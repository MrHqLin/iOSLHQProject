//
//  NSData+AES.m
//  GeeLockApp
//
//  Created by 吴琼 on 2018/10/13.
//  Copyright © 2018年 吴琼. All rights reserved.
//

#import "NSData+AES.h"

#import <CommonCrypto/CommonCrypto.h>

static NSString *stringKey = @"wtwd@geelocks123";

@implementation NSData (AES)

- (NSData *)aes128_CBC_PKCS7EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self aes128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)aes128_CBC_PKCS7DecryptWithKey:(NSData *)key iv:(NSData *)iv {
    return [self aes128Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)aes128Operation:(CCOperation)operation key:(NSData *)key iv:(NSData *)iv {
    
    char *keyPtr = (char *)[key bytes];
    char *ivPtr = (char *)[iv bytes];
    
    size_t bufferSize = [self length]+kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            keyPtr,
                                            kCCKeySizeAES128,
                                            ivPtr,
                                            [self bytes],
                                            [self length],
                                            buffer,
                                            bufferSize,
                                            &numBytesEncrypted);
    if (cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else {
        NSLog(@"error");
    }
    free(buffer);
    return nil;
}


#pragma mark --- 与后台通讯的加密解密的方式

- (NSData *)AES128EncryptWithKey:(NSString *)key {//加密
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


- (NSData *)AES128DecryptWithKey:(NSString *)key {//解密
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

@end
