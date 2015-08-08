//
//  BHNavigationItem.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import "BHNavigationItem.h"
#import "UIView+Accessor.h"
#import "BHNavigationMarcos.h"
#import "BHNavigationPushAnimation.h"
#import "UIViewController+BHNavigation.h"

@interface BHNavigationItem()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, assign) UIViewController *_bh_viewController;

@end

@implementation BHNavigationItem

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    if (!title) {
        _titleLabel.text = @"";
        return;
    }
    
    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_titleLabel setTextColor:kNavigationBarTintColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [__bh_viewController.bh_NavigationBar addSubview:_titleLabel];
    }
    
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    NSUInteger otherButtonWidth = self.leftBarButtonItem.view.width + self.rightBarButtonItem.view.width;
    _titleLabel.width = [UIScreen mainScreen].bounds.size.width - otherButtonWidth - 20;
    _titleLabel.centerY = 42;
    _titleLabel.centerX = [UIScreen mainScreen].bounds.size.width/2;
    
}

- (void)setLeftBarButtonItem:(BHBarButtonItem *)leftBarButtonItem {
    
    if (__bh_viewController) {
        [_leftBarButtonItem.view removeFromSuperview];
        leftBarButtonItem.view.x = 0;
        leftBarButtonItem.view.centerY = 42;
        [__bh_viewController.bh_NavigationBar addSubview:leftBarButtonItem.view];
    }
    
    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightBarButtonItem:(BHBarButtonItem *)rightBarButtonItem {
    
    if (__bh_viewController) {
        [_rightBarButtonItem.view removeFromSuperview];
        rightBarButtonItem.view.x = [UIScreen mainScreen].bounds.size.width - rightBarButtonItem.view.width;
        rightBarButtonItem.view.centerY = 42;
        [__bh_viewController.bh_NavigationBar addSubview:rightBarButtonItem.view];
    }
    
    _rightBarButtonItem = rightBarButtonItem;
    
}


@end
