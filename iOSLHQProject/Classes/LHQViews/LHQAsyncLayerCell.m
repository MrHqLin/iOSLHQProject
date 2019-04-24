//
//  LHQAsyncLayerCell.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/4/1.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQAsyncLayerCell.h"
#define SIZE_GAP_LEFT 15
#define SIZE_GAP_TOP 13
#define SIZE_AVATAR 40
#define SIZE_GAP_BIG 10
#define SIZE_GAP_IMG 5

@interface LHQAsyncLayerCell ()

@property (nonatomic, strong) UIImageView   *postBGView;
@property (nonatomic, strong) UIImageView   *avatarImage;
@property (nonatomic, strong) UIView        *nameLabel;
@property (nonatomic, strong) UIView        *subLabel;

@end

@implementation LHQAsyncLayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _postBGView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_postBGView];
//        [self draw];
    }
    return self;
}

- (void)setTest:(NSString *)test{
    _test = test;
    [self draw];
}

#pragma mark - draw
- (void)draw{
    LHQWeak(self);
    // 绘制之前须知h画布大小
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 100);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] set];
        CGContextFillRect(context, rect);
#warning 这里有个问题头像使用绘制怎么获取点击事件
        // 头像
        UIImage *avatarImage = [UIImage drawCircleImageWithImage:[UIImage imageNamed:@"avatar_normal"] size:CGSizeMake(SIZE_AVATAR, SIZE_AVATAR) cornerRadius:SIZE_AVATAR/2];
        [avatarImage drawInRect:CGRectMake(SIZE_GAP_LEFT, SIZE_GAP_TOP, SIZE_AVATAR, SIZE_AVATAR) blendMode:kCGBlendModeNormal alpha:1.0];
        // 用户
        float x = SIZE_GAP_LEFT + SIZE_AVATAR + SIZE_GAP_BIG;
        float y = SIZE_GAP_TOP;
        NSString *userName = weakself.test;
        [userName drawInContext:context withPosition:CGPointMake(x, y) andFont:AdaptedFontSize(14)
                   andTextColor:[UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1]
                      andHeight:rect.size.height];
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.postBGView.image = temp;
            weakself.postBGView.frame = rect;
        });
        
    });
}




@end
