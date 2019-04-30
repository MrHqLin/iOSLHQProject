//
//  ToolConfig.h
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/4/30.
//  Copyright © 2019年 water. All rights reserved.
//

#ifndef ToolConfig_h
#define ToolConfig_h

#define LHQWeak(type)  __weak typeof(type) weak##type = type
#define LHQKeyPath(obj, key) @(((void)obj.key, #key))
#define LHQIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// 异步主线程执行，不强持有Self
#define kRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

//不同屏幕尺寸字体适配
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]

#ifdef DEBUG
#define DLog(fmt,...)NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define LHQColorWithAlpha(r, g, b, a)   [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define LHQRandomColorWithAlpha(a)      [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:(a)]

#define UserDefaults  [NSUserDefaults standardUserDefaults]


#endif /* ToolConfig_h */
