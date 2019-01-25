//
//  LHQFormViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/1/25.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQFormViewController.h"
#import "LHQSettingCell.h"
#import <MOFSPickerManager.h>

@interface LHQFormViewController ()

@end

@implementation LHQFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHQWeak(self);
    LHQWordItem *item0 = [LHQWordArrowItem itemWithTitle:@"系统设置" subTitle:@"是你吗"];
    item0.image = [UIImage imageNamed:@"mine-setting-icon"];
    [item0 setItemOperation:^(NSIndexPath * _Nonnull indexPath) {
        [MBProgressHUD showAutoMessage:@"系统设置"];
    }];
    
    LHQWordItem *item1 = [LHQWordItem itemWithTitle:@"姓名" subTitle:@"请输入姓名"];
    item1.subTitleFont = AdaptedFontSize(14);
    item1.subTitleColor = [UIColor lightGrayColor];
    item1.subTitleNumberOfLines = 1;
    [item1 setItemOperation:^(NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
        UITextField *textF = [cell.contentView viewWithTag:indexPath.row + 100];
        // 创建textF
        if (!textF) {
            textF = [[UITextField alloc] init];
            textF.tag = indexPath.row + 100;
            textF.delegate = self;
            textF.lhq_size = CGSizeMake(100, 40);
            //            textF.textColor = [UIColor clearColor];
            //            textF.borderStyle = UITextBorderStyleNone;
            [cell.contentView addSubview:textF];
            textF.hidden = YES;
        }
        
        [textF becomeFirstResponder];
    }];
    
    LHQWordItem *item2 = [LHQWordArrowItem itemWithTitle:@"性别" subTitle:@"请选择出性别"];
    item2.subTitleColor = [UIColor lightGrayColor];
    LHQWeak(item2);
    [item2 setItemOperation:^(NSIndexPath * _Nonnull indexPath) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"男",@"女"] tag:1 title:nil cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
            weakitem2.subTitle = string;
            [weakself.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        } cancelBlock:^{
            
        }];
    }];
    
    LHQWordItem *item3 = [LHQWordArrowItem itemWithTitle:@"生日" subTitle: @"请选择出生日期"];
    item3.subTitleColor = [UIColor lightGrayColor];
    LHQWeak(item3);
    [item3 setItemOperation:^void(NSIndexPath *indexPath){
        [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
            weakitem3.subTitle = [date stringWithFormat:@"yyyy-MM-dd"];
            [weakself.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        } cancelBlock:^{
        }];
    }];
    
    LHQWordItem *item4 = [LHQWordArrowItem itemWithTitle:@"地址" subTitle: @"请选择地址"];
    item4.subTitleColor = [UIColor lightGrayColor];
    LHQWeak(item4);
    [item4 setItemOperation:^void(NSIndexPath *indexPath){
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
            
            weakitem4.subTitle = [NSString stringWithFormat:@"%@%@",address,zipcode];
            [weakself.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } cancelBlock:^{
            
        }];
    }];
    
    LHQWordItem *item5 = [LHQWordItem itemWithTitle:@"姓名" subTitle:@"请输入姓名"];
    item5.subTitleFont = AdaptedFontSize(14);
    item5.subTitleColor = [UIColor lightGrayColor];
    item5.subTitleNumberOfLines = 1;
    [item5 setItemOperation:^(NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
        UITextField *textF = [cell.contentView viewWithTag:indexPath.row + 100];
        // 创建textF
        if (!textF) {
            textF = [[UITextField alloc] init];
            textF.tag = indexPath.row + 100;
            textF.delegate = self;
            textF.lhq_size = CGSizeMake(100, 40);
            //            textF.textColor = [UIColor clearColor];
            //            textF.borderStyle = UITextBorderStyleNone;
            [cell.contentView addSubview:textF];
            textF.hidden = YES;
        }
        
        [textF becomeFirstResponder];
    }];
    
    LHQWordItem *item6 = [LHQWordItem itemWithTitle:@"姓名" subTitle:@"请输入姓名"];
    item6.subTitleFont = AdaptedFontSize(14);
    item6.subTitleColor = [UIColor lightGrayColor];
    item6.subTitleNumberOfLines = 1;
    [item6 setItemOperation:^(NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
        UITextField *textF = [cell.contentView viewWithTag:indexPath.row + 100];
        // 创建textF
        if (!textF) {
            textF = [[UITextField alloc] init];
            textF.tag = indexPath.row + 100;
            textF.delegate = self;
            textF.lhq_size = CGSizeMake(100, 40);
            //            textF.textColor = [UIColor clearColor];
            //            textF.borderStyle = UITextBorderStyleNone;
            [cell.contentView addSubview:textF];
            textF.hidden = YES;
        }
        
        [textF becomeFirstResponder];
    }];
    
    LHQItemSection *section0 = [LHQItemSection sectionWithItems:@[item0,item1,item2,item3,item4,item5,item6]
                                                 andHeaderTitle:nil
                                                    footerTitle:nil];
    [self.sections addObject:section0];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 九宫格输入 bug fix
    if ([@"➋➌➍➎➏➐➑➒" rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string.stringByTrim].stringByTrim;
    NSLog(@"%@", textField.text);
    NSLog(@"%@", current);
    NSLog(@"%@", string);
    
    LHQWordItem *item = self.sections.firstObject.items[textField.tag - 100];
    item.subTitle = current;
    
    LHQSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag - 100 inSection:0]];
    cell.item = item;
    
    return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

#pragma mark -- UITableViewCellDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHQWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    LHQSettingCell *cell = [LHQSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


#pragma mark - LHQTextViewControllerDataSource
- (BOOL)textViewControllerEnableAutoToolbar:(LHQTextViewVC *)textViewController{
    return YES;
}

#pragma mark - LHQNavUIBaseViewControllerDelegate
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"表单填写"];
}

@end
