//
//  BHNavigationPushAnimation.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import "BHNavigationPushAnimation.h"
#import "UIViewController+BHNavigation.h"
#import "BHNavigationMarcos.h"
#import "UIView+Accessor.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@implementation BHNavigationPushAnimation

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    fromViewController.view.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(fromViewController.view.frame));
    toViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(toViewController.view.frame));
    
    // Configure Navi Transition
    
    UIView *naviBarView;
    
    UIView *toNaviLeft;
    UIView *toNaviRight;
    UIView *toNaviTitle;
    
    UIView *fromNaviLeft;
    UIView *fromNaviRight;
    UIView *fromNaviTitle;
    
    if (fromViewController.bh_isNavigationBarHidden || toViewController.bh_isNavigationBarHidden) {
        ;
    } else {
        
        naviBarView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 64}];
        naviBarView.backgroundColor = kNavigationBarColor;
        [containerView addSubview:naviBarView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){0, 64, kScreenWidth, 0.5}];
        lineView.backgroundColor = kNavigationBarLineColor;
        [naviBarView addSubview:lineView];
        
        toNaviLeft = toViewController.bh_NavigationItem.leftBarButtonItem.view;
        toNaviRight = toViewController.bh_NavigationItem.rightBarButtonItem.view;
        toNaviTitle = toViewController.bh_NavigationItem.titleLabel;
        
        fromNaviLeft = fromViewController.bh_NavigationItem.leftBarButtonItem.view;
        fromNaviRight = fromViewController.bh_NavigationItem.rightBarButtonItem.view;
        fromNaviTitle = fromViewController.bh_NavigationItem.titleLabel;
        
        [containerView addSubview:toNaviLeft];
        [containerView addSubview:toNaviTitle];
        [containerView addSubview:toNaviRight];
        
        [containerView addSubview:fromNaviLeft];
        [containerView addSubview:fromNaviTitle];
        [containerView addSubview:fromNaviRight];
        
        fromNaviLeft.alpha = 1.0;
        fromNaviRight.alpha =  1.0;
        fromNaviTitle.alpha = 1.0;
        
        toNaviLeft.alpha = 0.0;
        toNaviRight.alpha = 0.0;
        toNaviTitle.alpha = 0.0;
        toNaviTitle.centerX = 44;
        
        toNaviLeft.x = 0;
        toNaviTitle.centerX = kScreenWidth;
        toNaviRight.x = kScreenWidth+70 - toNaviRight.width;
        
    }
    
    // End configure
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.x = 0;
        fromViewController.view.x = -120;
        
        fromNaviLeft.alpha = 0;
        fromNaviRight.alpha =  0;
        fromNaviTitle.alpha = 0;
        fromNaviTitle.centerX = 0;
        
        toNaviLeft.alpha = 1.0;
        toNaviRight.alpha = 1.0;
        toNaviTitle.alpha = 1.0;
        toNaviTitle.centerX = kScreenWidth/2;
        toNaviLeft.x = 0;
        toNaviRight.x = kScreenWidth - toNaviRight.width;
        
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
        fromNaviLeft.alpha = 1.0;
        fromNaviRight.alpha = 1.0;
        fromNaviTitle.alpha = 1.0;
        fromNaviTitle.centerX = kScreenWidth/2;
        fromNaviLeft.x = 0;
        fromNaviRight.x = kScreenWidth - fromNaviRight.width;
        
        [naviBarView removeFromSuperview];
        
        [toNaviLeft removeFromSuperview];
        [toNaviTitle removeFromSuperview];
        [toNaviRight removeFromSuperview];
        
        [fromNaviLeft removeFromSuperview];
        [fromNaviTitle removeFromSuperview];
        [fromNaviRight removeFromSuperview];
        
        [toViewController.bh_NavigationBar addSubview:toNaviLeft];
        [toViewController.bh_NavigationBar addSubview:toNaviTitle];
        [toViewController.bh_NavigationBar addSubview:toNaviRight];
        
        [fromViewController.bh_NavigationBar addSubview:fromNaviLeft];
        [fromViewController.bh_NavigationBar addSubview:fromNaviTitle];
        [fromViewController.bh_NavigationBar addSubview:fromNaviRight];
        
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}


@end
