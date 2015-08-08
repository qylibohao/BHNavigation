//
//  BHBarButtonItem.h
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 Email : libohao@kingsoft.com, . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BHBarButtonItemStyle) {
    BHBarButtonItemStylePlain,
    BHBarButtonItemStyleBordered,
    BHBarButtonItemStyleDone,
};

@interface BHBarButtonItem : NSObject

@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign, getter = isEnabled) BOOL enabled;

- (instancetype)initWithTitle:(NSString *)title style:(BHBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)initWithImage:(UIImage *)image style:(BHBarButtonItemStyle)style handler:(void (^)(id sender))action;

@end
