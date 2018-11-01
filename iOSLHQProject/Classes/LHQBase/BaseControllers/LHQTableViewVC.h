//
//  LHQTableViewVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQBaseViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHQTableViewVC : LHQBaseViewVC <UITableViewDataSource,UITableViewDelegate>

// 这个代理方法如果子类实现了, 必须调用super
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
