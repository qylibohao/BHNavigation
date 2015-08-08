//
//  BHBarButtonItem.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 Email : libohao@kingsoft.com, . All rights reserved.
//

#import "BHBarButtonItem.h"
#import "BHNavigationMarcos.h"
#import "UIView+Accessor.h"

@interface BHBarButtonItem()

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, copy) void (^actionBlock)(id);


@end

@implementation BHBarButtonItem


- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title style:(BHBarButtonItemStyle)style handler:(void (^)(id sender))action {
    
    if ([self init]) {
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:kNavigationBarTintColor forState:UIControlStateNormal];
        [button sizeToFit];
        button.height = 44;
        button.width += 30;
        button.centerY = 20 + 22;
        button.x = 0;
        self.view = button;
        
        self.actionBlock = action;
        
        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(BHBarButtonItemStyle)style handler:(void (^)(id sender))action {
    
    if ([self init]) {
        
        self.buttonImage = image;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.height = 44;
        button.width += 30;
        button.centerY = 20 + 22;
        button.x = 0;
        self.view = button;
        
        self.actionBlock = action;
        
        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    if (enabled) {
        self.view.userInteractionEnabled = YES;
        self.view.alpha = 1.0;
    } else {
        self.view.userInteractionEnabled = NO;
        self.view.alpha = 0.3;
    }
    
}

#pragma mark - Private Methods

- (void)handleTouchUpInside:(UIButton *)button {
    
    self.actionBlock(button);
    [UIView animateWithDuration:0.2 animations:^{
        button.alpha = 1.0;
    }];
    
}

- (void)handleTouchDown:(UIButton *)button {
    
    button.alpha = 0.3;
    
}

- (void)handleTouchUp:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        button.alpha = 1.0;
    }];
    
}


@end
