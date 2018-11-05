//
//  LHQCollectionVC.h
//  iOSLHQProject
//
//  Created by LIN on 2018/11/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQBaseViewVC.h"
#import "LHQElementsFlowLayout.h"
#import "LHQVerticalFlowLayout.h"
#import "LHQHorizontalFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class LHQCollectionVC;

@protocol LHQCollectionViewControllerDataSource <NSObject>

@required

// 需要返回对应的布局
- (UICollectionViewLayout *)collectionViewController:(LHQCollectionVC *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end

@interface LHQCollectionVC : LHQBaseViewVC <UICollectionViewDelegate, UICollectionViewDataSource, LHQCollectionViewControllerDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;



@end

NS_ASSUME_NONNULL_END
