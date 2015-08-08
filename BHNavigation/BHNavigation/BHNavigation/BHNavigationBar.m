//
//  BHNavigationBar.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import "BHNavigationBar.h"
#import "BHNavigationMarcos.h"
#import "UIView+Accessor.h"

@interface BHNavigationBar ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation BHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = (CGRect){0, 0, [UIScreen mainScreen].bounds.size.width, 64};
        
        self.backgroundColor = kNavigationBarColor;
        
        self.lineView = [[UIView alloc] initWithFrame:(CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, 0.5}];
        self.lineView.backgroundColor = kNavigationBarLineColor;
        [self addSubview:self.lineView];
        
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)didReceiveThemeChangeNotification {
    
    self.backgroundColor = kNavigationBarColor;
    self.lineView.backgroundColor = kNavigationBarLineColor;
    
}


@end
