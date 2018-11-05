//
//  LHQElementsFlowLayout.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/5.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQElementsFlowLayout.h"

#define LHQXX(x) floorf(x)
#define LHQXS(s) ceilf(s)

static const CGFloat LHQ_XMargin_ = 10;
static const CGFloat LHQ_YMargin_ = 10;
static const UIEdgeInsets LHQ_EdgeInsets_ = {20, 10, 10, 10};

@interface LHQElementsFlowLayout ()

/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *lhq_AtrbsArray;

/** 每一列的最后的高度 */
@property (assign, nonatomic) CGRect lhq_LastAtrbsFrame;


- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)edgeInsets;

- (CGRect)maxHeightFrame;

@end

@implementation LHQElementsFlowLayout


/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //如果重新刷新就需要移除之前存储的高度
    //复赋值以顶部的高度, 并且根据列数
    self.lhq_LastAtrbsFrame = CGRectMake(0, 0, self.collectionView.frame.size.width, 0);
    
    // 移除以前计算的cells的attrbs
    [self.lhq_AtrbsArray removeAllObjects];
    
    // 并且重新计算, 每个cell对应的atrbs, 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
        [self.lhq_AtrbsArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

/**
 * 在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 原来的
    CGSize itemSize = [self.delegate waterflowLayout:self collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];
    
    CGFloat w = LHQXX(itemSize.width);
    w = MIN(w, self.collectionView.frame.size.width);
    
    // 高度由外界决定, 外界必须实现这个方法
    CGFloat h = itemSize.height;
    
    // 拿到最后的高度最小的那一列, 假设第0列最小
    CGFloat rightLeftWidth = self.collectionView.frame.size.width - CGRectGetMaxX(self.lhq_LastAtrbsFrame) - [self xMarginAtIndexPath:indexPath] - self.edgeInsets.right;
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    if (rightLeftWidth >= w) {
        
        x = CGRectGetMaxX(self.lhq_LastAtrbsFrame) + [self xMarginAtIndexPath:indexPath];
        y = self.lhq_LastAtrbsFrame.origin.y;
        
    }else
    {
        x = self.edgeInsets.left;
        y = CGRectGetMaxY(self.maxHeightFrame) + [self yMarginAtIndexPath:indexPath];
    }
    
    if (w > self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right) {
        x = (self.collectionView.frame.size.width - w) * 0.5;
    }
    
    if (y <= [self yMarginAtIndexPath:indexPath]) {
        y = self.edgeInsets.top;
    }
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新高度
    self.lhq_LastAtrbsFrame = atrbs.frame;
    
    return atrbs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.lhq_AtrbsArray;
}


- (CGRect)maxHeightFrame
{
    __block CGRect maxHeightFrame = self.lhq_LastAtrbsFrame;
    
    [self.lhq_AtrbsArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectGetMaxY(obj.frame) > CGRectGetMaxY(maxHeightFrame)) {
            maxHeightFrame = obj.frame;
        }
    }];
    
    return maxHeightFrame;
}



- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, CGRectGetMaxY(self.maxHeightFrame) + self.edgeInsets.bottom);
}

- (NSMutableArray *)lhq_AtrbsArray
{
    if(_lhq_AtrbsArray == nil)
    {
        _lhq_AtrbsArray = [NSMutableArray array];
    }
    return _lhq_AtrbsArray;
}


- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:columnsMarginForItemAtIndexPath:)])
    {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView columnsMarginForItemAtIndexPath:indexPath];
    }
    else
    {
        return LHQ_XMargin_;
    }
}

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:linesMarginForItemAtIndexPath:)])
    {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    }else
    {
        return LHQ_YMargin_;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if([self.delegate respondsToSelector:@selector(waterflowLayout:edgeInsetsInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self edgeInsetsInCollectionView:self.collectionView];
    }
    else
    {
        return LHQ_EdgeInsets_;
    }
}

- (id<LHQElementsFlowLayoutDelegate>)delegate
{
    return (id<LHQElementsFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (instancetype)initWithDelegate:(id<LHQElementsFlowLayoutDelegate>)delegate
{
    if (self = [super init]) {
        
    }
    return self;
}


+ (instancetype)flowLayoutWithDelegate:(id<LHQElementsFlowLayoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}

@end
