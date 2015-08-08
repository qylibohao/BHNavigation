//
//  UIViewController+BHNavigation.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import "UIViewController+BHNavigation.h"
#import <objc/runtime.h>
#import "BHNavigationMarcos.h"
#import "UIView+Accessor.h"

static char const * const kNaviHidden = "kSPNaviHidden";
static char const * const kNaviBar = "kSPNaviBar";
static char const * const kNaviBarView = "kNaviBarView";

@implementation UIViewController (BHNavigation)

@dynamic bh_NavigationItem;
@dynamic bh_NavigationBar;
@dynamic bh_navigationBarHidden;

- (BOOL)bh_isNavigationBarHidden {
    return [objc_getAssociatedObject(self, kNaviHidden) boolValue];
}

- (void)setBh_navigationBarHidden:(BOOL)bh_navigationBarHidden {
    objc_setAssociatedObject(self, kNaviHidden, @(bh_navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

- (void)bh_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bh_NavigationBar.y = -44;
            for (UIView *view in self.bh_NavigationBar.subviews) {
                view.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            self.bh_navigationBarHidden = YES;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.bh_NavigationBar.y = 0;
            for (UIView *view in self.bh_NavigationBar.subviews) {
                view.alpha = 1.0;
            }
        } completion:^(BOOL finished) {
            self.bh_navigationBarHidden = NO;
        }];
    }
}

- (BHNavigationItem *)bh_NavigationItem {
    return objc_getAssociatedObject(self, kNaviBar);
}

- (void)setBh_NavigationItem:(BHNavigationItem *)bh_navigationItem {
    objc_setAssociatedObject(self, kNaviBar, bh_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)bh_NavigationBar {
    return objc_getAssociatedObject(self, kNaviBarView);
}

- (void)setBh_NavigationBar:(UIView *)bh_navigationBar {
    objc_setAssociatedObject(self, kNaviBarView, bh_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)naviBeginRefreshing {
    
    UIActivityIndicatorView *activityView;
    for (UIView *view in self.bh_NavigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
        if ([view isEqual:self.bh_NavigationItem.rightBarButtonItem.view]) {
            [view removeFromSuperview];
        }
    }
    
    if (!activityView) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setColor:[UIColor blackColor]];
        activityView.frame = (CGRect){[UIScreen mainScreen].bounds.size.width - 42, 25, 35, 35};
        [self.bh_NavigationBar addSubview:activityView];
    }
    
    [activityView startAnimating];
    
}


- (void)naviEndRefreshing {
    
    UIActivityIndicatorView *activityView;
    for (UIView *view in self.bh_NavigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
    }
    
    if (self.bh_NavigationItem.rightBarButtonItem) {
        [self.bh_NavigationBar addSubview:self.bh_NavigationItem.rightBarButtonItem.view];
    }
    
    [activityView stopAnimating];
    
}

@end
