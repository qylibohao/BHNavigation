//
//  BHNavigationItem.h
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 QQ : 375795423 . Email:libohao@kingsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BHBarButtonItem;

@interface BHNavigationItem : NSObject

@property (nonatomic, strong  ) BHBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong  ) BHBarButtonItem *rightBarButtonItem;
@property (nonatomic, copy    ) NSString        *title;

@property (nonatomic, readonly) UIView          *titleView;
@property (nonatomic, readonly) UILabel         *titleLabel;

@end
