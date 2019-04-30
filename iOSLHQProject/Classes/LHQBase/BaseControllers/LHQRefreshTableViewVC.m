//
//  LHQRefreshTableViewVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQRefreshTableViewVC.h"

@interface LHQRefreshTableViewVC ()

@end

@implementation LHQRefreshTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWeak(self);
    self.tableView.mj_header = [LHQNormalRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadIsMore:NO];
    }];
    self.tableView.mj_footer = [LHQAutoRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadIsMore:YES];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
    }else
    {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
    }
    [self loadMore:isMore];
}


// 结束刷新
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.mj_footer.pullingPercent = 1;
    });
}

// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    // NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}

@end
