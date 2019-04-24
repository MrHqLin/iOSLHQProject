//
//  LHQPullMenuViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/26.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQPullMenuViewController.h"

@interface LHQPullMenuViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation LHQPullMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    self.headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(-100 + self.lhq_navigationBar.height, 0, 0, 0);
//    UIEdgeInsets contentInset = self.tableView.contentInset;
//    contentInset.top -= 125;
//    self.tableView.contentInset = contentInset;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat offsetY = scrollView.contentOffset.y;
    DLog(@"offsetY = %.2f",offsetY);
    LHQWeak(self);
    if (self.isShow) {
        // 隐藏
        if (offsetY > 45 - self.lhq_navigationBar.height) {
            self.tableView.contentInset = UIEdgeInsetsMake(-100 + self.lhq_navigationBar.height, 0, 0, 0);
            self.isShow = NO;
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView setContentOffset:CGPointMake(0,-self.lhq_navigationBar.height) animated:YES];
            });
        }
    } else {
        // 显示
        if (offsetY < 80 - self.lhq_navigationBar.height) {
            self.tableView.contentInset = UIEdgeInsetsMake(self.lhq_navigationBar.height, 0, 0, 0);
            self.isShow = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView setContentOffset:CGPointMake(0,-self.lhq_navigationBar.height) animated:YES];
            });
        }
    }
}


#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

#pragma mark - NavigationBarDataSource
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"仿微信首页小程序下拉菜单"];
}


@end
