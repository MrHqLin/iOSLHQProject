//
//  LHQStaticTableVC.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQStaticTableVC.h"
#import "LHQSettingCell.h"

UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;

@interface LHQStaticTableVC ()

@end

@implementation LHQStaticTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHQWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    LHQSettingCell *cell = [LHQSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    
    cell.item = item;
    
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LHQWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 普通的cell
    if(item.itemOperation)
    {
        item.itemOperation(indexPath);
        return;
    }
    
    // 带箭头的cell
    if([item isKindOfClass:[LHQWordArrowItem class]])
    {
        LHQWordArrowItem *arrowItem = (LHQWordArrowItem *)item;
        
        if(arrowItem.destVc)
        {
            UIViewController *vc = [[arrowItem.destVc alloc] init];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.navigationItem.title = arrowItem.title;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sections[section].footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}


- (NSMutableArray<LHQItemSection *> *)sections
{
    if(_sections == nil)
    {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (LHQStaticTableVC *(^)(LHQWordItem *))addItem {
    
    LHQWeak(self);
    if (!self.sections.firstObject) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
        [self.sections addObject:[LHQItemSection sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
#pragma clang diagnostic pop
    }
    return  ^LHQStaticTableVC *(LHQWordItem *item) {
        [weakself.sections.firstObject.items addObject:item];
        return weakself;
    };
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

@end
