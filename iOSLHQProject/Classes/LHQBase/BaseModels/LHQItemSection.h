//
//  LHQItemSection.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHQWordItem;

@interface LHQItemSection : NSObject

@property (nonatomic, copy) NSString *headerTitle;

@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) NSMutableArray<LHQWordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<LHQWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end

