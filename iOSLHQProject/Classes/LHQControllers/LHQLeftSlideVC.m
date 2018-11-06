//
//  LHQLeftSlideVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQLeftSlideVC.h"
#import "LHQAppDelegate.h"
#import "LHQMessageViewVC.h"
#import "LHQMeViewVC.h"
#import "LHQHomeViewVC.h"

@interface LHQLeftSlideVC ()

@end

@implementation LHQLeftSlideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top += self.lhq_navigationBar.lhq_height;
    self.tableView.contentInset = contentInset;
    
    LHQWeak(self);
    LHQWordArrowItem *item01 = [LHQWordArrowItem itemWithTitle:@"item01" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        DLog(@"1");
        LHQAppDelegate *appDelegate = (LHQAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.mainVc closeLeftView];
        LHQNavigationVC *nav = (LHQNavigationVC *)appDelegate.tabBarVc.childViewControllers[0];
        [nav pushViewController:[[LHQMessageViewVC alloc]init] animated:YES];
    }];
    item01.destVc = [LHQMessageViewVC class];
    
    LHQWordArrowItem *item02 = [LHQWordArrowItem itemWithTitle:@"item02" subTitle:@"" itemOperation:^(NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    LHQWordArrowItem *item03 = [LHQWordArrowItem itemWithTitle:@"item03" subTitle:@""];
    item03.destVc = [LHQMeViewVC class];
    
    LHQItemSection *section01 = [LHQItemSection sectionWithItems:@[item01,item02,item03] andHeaderTitle:@"" footerTitle:@"嘿嘿"];
    
    [self.sections addObject:section01];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
//- (instancetype)init
//{
//    return [super initWithStyle:UITableViewStylePlain];
//}

@end
