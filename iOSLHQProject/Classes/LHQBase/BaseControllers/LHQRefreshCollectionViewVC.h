//
//  LHQRefreshCollectionViewVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/6.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQCollectionVC.h"
#import "LHQNormalRefreshHeader.h"
#import "LHQAutoRefreshFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHQRefreshCollectionViewVC : LHQCollectionVC

- (void)loadMore:(BOOL)isMore;

// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;


@end

NS_ASSUME_NONNULL_END
