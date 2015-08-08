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

@property (nonatomic, strong) UILabel  *switchLabel;
@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UISwitch *switchCtrl;

@end

@implementation BHViewController

#pragma mark - Property

- (UILabel* )switchLabel {
    if (!_switchLabel) {
        _switchLabel = [[UILabel alloc] initWithFrame:(CGRect){20, 153, 100, 44}];
        _switchLabel.font = [UIFont systemFontOfSize:15];
        _switchLabel.text = @"隐藏导航栏 :";
    }
    return _switchLabel;
}

- (UISwitch* )switchCtrl {
    if (!_switchCtrl) {
        _switchCtrl = [[UISwitch alloc] initWithFrame:(CGRect){160, 160, 90, 44}];
        [_switchCtrl addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        _switchCtrl.on = NO;
    }
    return _switchCtrl;
}

- (UIButton* )pushButton {
    if (!_pushButton) {
        _pushButton = [[UIButton alloc] initWithFrame:(CGRect){20, 230, 200, 44}];
        [_pushButton setTitle:@"push" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[self randomColor] forState:UIControlStateNormal];
        _pushButton.backgroundColor = [self randomColor];
        [_pushButton addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [self randomColor];
    
    [self.view addSubview:self.switchLabel];
    [self.view addSubview:self.switchCtrl];
    self.switchCtrl.on = NO;
    [self.view addSubview:self.pushButton];
    
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


#pragma mark - Functions

- (UIColor*)randomColor {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    return [UIColor colorWithRed:red
                            green:green
                             blue:blue
                            alpha:1.0];
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
