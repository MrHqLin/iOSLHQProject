//
//  LHQItemSection.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQItemSection.h"

@implementation LHQItemSection

+ (instancetype)sectionWithItems:(NSArray<LHQWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    LHQItemSection *item = [[self alloc] init];
    if (items.count) {
        [item.items addObjectsFromArray:items];
    }
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

- (NSMutableArray<LHQWordItem *> *)items
{
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
