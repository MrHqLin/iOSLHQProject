//
//  LHQLottieViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/19.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQLottieViewController.h"
#import <Lottie/Lottie.h>

@interface LHQLottieViewController ()

@property (nonatomic, strong) LOTAnimationView *lottieLogo;
@property (nonatomic, strong) LOTAnimationView *lottiePaoPao;
@property (nonatomic, strong) UIButton *lottieButton;

@end

@implementation LHQLottieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lottieLogo = [LOTAnimationView animationNamed:@"haima"];
    self.lottieLogo.frame = CGRectMake(50, 64, kScreenWidth-100, kScreenHeight-64);
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFit;
    self.lottieLogo.layer.masksToBounds = YES;
    [self.view addSubview:self.lottieLogo];
    
    self.lottiePaoPao = [LOTAnimationView animationNamed:@"paopao"];
    self.lottiePaoPao.frame = CGRectMake(50, 64, kScreenWidth-100, kScreenHeight-64);
    self.lottiePaoPao.contentMode = UIViewContentModeScaleAspectFit;
    self.lottiePaoPao.layer.masksToBounds = YES;
    [self.view addSubview:self.lottiePaoPao];
    
    self.lottieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lottieButton.frame = self.lottieLogo.bounds;
    [self.lottieButton addTarget:self action:@selector(_playLottieAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lottieButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
    [self.lottiePaoPao play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
    [self.lottiePaoPao pause];
}


- (void)_playLottieAnimation{
    self.lottieLogo.animationProgress = 0;
    [self.lottieLogo play];
    
    self.lottiePaoPao.animationProgress = 0;
    [self.lottiePaoPao play];
}


@end
