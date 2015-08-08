//
//  UIViewController+BHNavigation.h
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BHBarButtonItem.h"
#import "BHNavigationItem.h"

@interface UIViewController (BHNavigation)

@property (nonatomic, strong) BHNavigationItem *bh_NavigationItem;
@property (nonatomic, strong) UIView *bh_NavigationBar;

@property(nonatomic, getter = bh_isNavigationBarHidden) BOOL bh_navigationBarHidden;

- (void)bh_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)naviBeginRefreshing;
- (void)naviEndRefreshing;


@end
