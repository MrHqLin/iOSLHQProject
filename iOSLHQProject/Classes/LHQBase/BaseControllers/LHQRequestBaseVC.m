//
//  LHQRequestBaseVc.m
//  iOSLHQProject
//
//  Created by LIN on 2018/11/1.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQRequestBaseVC.h"

@interface LHQRequestBaseVC ()

@property (nonatomic, strong) Reachability *reachHost;

@end

@implementation LHQRequestBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reachHost];
}


#pragma mark - loading
- (void)showLoading{
    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#define kURL_Reachability__Address @"www.baidu.com"
#pragma mark - 监听网络状态
- (Reachability *)reachHost
{
    if(_reachHost == nil)
    {
        _reachHost = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
        LHQWeak(self);
        [_reachHost setUnreachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        
        [_reachHost setReachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        [_reachHost startNotifier];
    }
    return _reachHost;
}

#pragma mark - LHQRequestBaseViewControllerDelegate
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(LHQRequestBaseVC *)inViewController
{
    // network status
    switch (networkStatus) {
        case NotReachable:
            [MBProgressHUD showError:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        case ReachableViaWiFi:
            DLog(@"wifi上网");
            break;
        case ReachableViaWWAN:
            DLog(@"手机上网");
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    if ([self isViewLoaded]) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }
    [_reachHost stopNotifier];
    _reachHost = nil;
}


@end
