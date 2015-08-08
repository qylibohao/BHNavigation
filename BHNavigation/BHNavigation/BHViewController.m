//
//  ViewController.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 libohao. All rights reserved.
//

#import "BHViewController.h"
#import "BHNavigation.h"

static NSInteger pushedCount = 0;


@interface BHViewController ()

@end

@implementation BHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red
                                               green:green
                                                 blue:blue
                                                alpha:1.0];
    
    
    
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:(CGRect){20, 153, 100, 44}];
    switchLabel.font = [UIFont systemFontOfSize:15];
    switchLabel.text = @"隐藏导航栏 :";
    [self.view addSubview:switchLabel];
    
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:(CGRect){160, 160, 90, 44}];
    [aSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:aSwitch];
    aSwitch.on = NO;
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:(CGRect){20, 230, 200, 44}];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor grayColor];
    [pushButton addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    self.bh_NavigationItem.title = [NSString stringWithFormat:@"第 %ld 页", (long)pushedCount];
    
    __weak typeof(BHViewController) *weakSelf = self;
    
    if (pushedCount > 0) {
        self.bh_NavigationItem.leftBarButtonItem = [[BHBarButtonItem alloc] initWithTitle:@"返回" style:BHBarButtonItemStylePlain handler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    self.bh_NavigationItem.rightBarButtonItem = [[BHBarButtonItem alloc] initWithTitle:@"下一页" style:BHBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf pushToNextVC];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushToNextVC {
    
    BHViewController *vc = [[BHViewController alloc] init];
    pushedCount ++;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)switchChange:(UISwitch *)aSwitch {
    
    if (aSwitch.isOn) {
        [self bh_setNavigationBarHidden:YES animated:YES];
    } else {
        [self bh_setNavigationBarHidden:NO animated:YES];
    }
}

@end
