//
//  LHQSettingCell.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/2.
//  Copyright © 2018年 water. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LHQWordItem;

@interface LHQSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;

/** 静态单元格模型 */
@property (nonatomic, strong) LHQWordItem *item;


@end

NS_ASSUME_NONNULL_END
