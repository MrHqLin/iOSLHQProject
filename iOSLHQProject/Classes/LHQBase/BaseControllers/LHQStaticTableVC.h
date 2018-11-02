//
//  LHQStaticTableVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQTableViewVC.h"
#import "LHQWordItem.h"
#import "LHQWordArrowItem.h"
#import "LHQItemSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHQStaticTableVC : LHQTableViewVC

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray<LHQItemSection *> *sections;

// 自定义某一行cell的时候调用super, 返回为空
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (LHQStaticTableVC *(^)(LHQWordItem *item))addItem;

@end

UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;


NS_ASSUME_NONNULL_END
