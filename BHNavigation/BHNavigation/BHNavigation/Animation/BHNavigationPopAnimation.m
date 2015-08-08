//
//  BHNavigationPopAnimation.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import "BHNavigationPopAnimation.h"
#import "UIView+Accessor.h"
#import "UIViewController+BHNavigation.h"
#import "BHNavigationMarcos.h"

static const CGFloat kToBackgroundInitAlpha = 0.08;

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)


@interface BHNavigationPopAnimation()

@property (nonatomic, strong) UIView      *toBackgroundView;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UIView      *naviContainView;

@end

@implementation BHNavigationPopAnimation

- (instancetype)init {
    if (self = [super init]) {
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.toBackgroundView = [[UIView alloc] init];
        
        self.shadowImageView = [[UIImageView alloc] initWithFrame:(CGRect){-10, 0, 10, screenHeight}];
        self.shadowImageView.image = [UIImage imageNamed:@"navi_shadow"];
        self.shadowImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.naviContainView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 64}];
        self.naviContainView.backgroundColor = [UIColor colorWithRed:0.774 green:0.368 blue:1.000 alpha:0.810];
        
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:fromViewController.view];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView insertSubview:self.toBackgroundView belowSubview:fromViewController.view];
    [containerView insertSubview:self.shadowImageView belowSubview:fromViewController.view];
    toViewController.view.frame = CGRectMake(-90, 0, kScreenWidth, CGRectGetHeight(toViewController.view.frame));
    self.toBackgroundView.frame = CGRectMake(-90, 0, kScreenWidth, CGRectGetHeight(toViewController.view.frame));
    self.shadowImageView.x = - 10;
    self.shadowImageView.alpha = 1.3;
    
    self.toBackgroundView.backgroundColor = [UIColor blackColor];
    self.toBackgroundView.alpha = kToBackgroundInitAlpha;
    
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
        
        [containerView addSubview:toNaviTitle];
        [containerView addSubview:fromNaviTitle];
        
        [containerView addSubview:toNaviLeft];
        [containerView addSubview:toNaviRight];
        
        [containerView addSubview:fromNaviLeft];
        [containerView addSubview:fromNaviRight];
        
        fromNaviLeft.alpha = 1.0;
        fromNaviRight.alpha =  1.0;
        fromNaviTitle.alpha = 1.0;
        fromNaviLeft.x = 0;
        fromNaviRight.x = kScreenWidth - fromNaviRight.width;
        
        toNaviLeft.alpha = 0.0;
        toNaviRight.alpha = 0.0;
        toNaviTitle.alpha = 0.0;
        toNaviTitle.centerX = 44;
        
    }
    
    // End configure
    
    [UIView animateWithDuration:duration animations:^{
        
        toViewController.view.x = 0;
        self.toBackgroundView.x = 0;
        fromViewController.view.x = kScreenWidth;
        
        self.shadowImageView.alpha = 0.2;
        self.shadowImageView.x = kScreenWidth - 7;
        
        
        self.toBackgroundView.alpha = 0.0;
        fromNaviLeft.alpha = 0;
        fromNaviRight.alpha =  0;
        fromNaviTitle.alpha = 0;
        fromNaviTitle.centerX = kScreenWidth + 10;
        
        toNaviLeft.alpha = 1.0;
        toNaviRight.alpha = 1.0;
        toNaviTitle.alpha = 1.0;
        toNaviTitle.centerX = kScreenWidth/2;
        
    } completion:^(BOOL finished) {
        
        if (transitionContext.transitionWasCancelled) {
            toNaviLeft.alpha = 1.0;
            toNaviRight.alpha = 1.0;
            toNaviTitle.alpha = 1.0;
            toNaviTitle.centerX = kScreenWidth/2;
            self.toBackgroundView.alpha = kToBackgroundInitAlpha;
        }
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
        [naviBarView removeFromSuperview];
        [self.toBackgroundView removeFromSuperview];
        
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
