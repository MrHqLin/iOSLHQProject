//
//  LHQAsyncLayerViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/4/1.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQAsyncLayerViewController.h"
#import "LHQAsyncLayerCell.h"

@interface LHQAsyncLayerViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation LHQAsyncLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = [NSMutableArray new];
    for (int i = 0; i < 200; i ++) {
        NSString *string = [NSString stringWithFormat:@"lindaye%d",i];
        [_datas addObject:string];
    }
    [self.tableView reloadData];
}

#pragma mark -- TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHQAsyncLayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LHQAsyncLayerCell class])];
    if (!cell) {
        cell = [[LHQAsyncLayerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LHQAsyncLayerCell class])];
    }
    cell.test = _datas[indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - dataSource
- (void)rightButtonEvent:(UIButton *)sender navigationBar:(LHQNavigationBar *)navigationBar{
    _datas[2] = @"haha";
    [self.tableView reloadData];
}

- (UIView *)lhqNavigationBarRightView:(LHQNavigationBar *)navigationBar{
    UIButton *button = [UIButton lhq_textButton:@"刷新" fontSize:14 normalColor:[UIColor blackColor] selectedColor:nil];
    button.frame = CGRectMake(0, 0, 50, 40);
    return button;
}

- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"异步绘制"];
}

@end
