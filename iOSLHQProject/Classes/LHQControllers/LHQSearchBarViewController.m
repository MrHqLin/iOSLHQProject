//
//  LHQSearchBarViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2018/12/7.
//  Copyright © 2018年 water. All rights reserved.
//

#import "LHQSearchBarViewController.h"
#import "LHQSearchBar.h"

@interface LHQSearchBarViewController () <UISearchBarDelegate>

@property (nonatomic, strong) LHQSearchBar *searchBar;
@property (nonatomic, strong) UISearchBar  *defaultBar;
@property (nonatomic, strong) UITextField  *textField;

@end

@implementation LHQSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[LHQSearchBar alloc]initWithFrame:CGRectMake(100, 100, 250, 44)];
    _searchBar.placeHolderString = @"请输入要搜索的故事";
    _searchBar.placeHolderStringColor = [UIColor orangeColor];
    _searchBar.placeHolderStringFont = AdaptedFontSize(14);
    _searchBar.cornerRadius = 20;
    _searchBar.clearBtnHidden = YES;
    _searchBar.showsCancelButton = NO;
    _searchBar.cancelBtnTitle = @"取消";
    _searchBar.delegate = self;
    _searchBar.cancelBtnTitleColor = [UIColor blackColor];
    [self.view addSubview:_searchBar];
    
    _defaultBar = [[UISearchBar alloc]initWithFrame:CGRectMake(100, 200, 250, 44)];
    _defaultBar.placeholder = @"请输入要搜索的故事";
    _defaultBar.delegate = self;
    [self.view addSubview:_defaultBar];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 300, 250, 44)];
    _textField.placeholder = @"请输入要搜索的故事";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 400, 80, 40);
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)tap{
    
    _searchBar.text = @"你还会飘吗";
    _defaultBar.text = @"你还会飘吗";
    _textField.text = @"你还会飘吗";
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}



@end
