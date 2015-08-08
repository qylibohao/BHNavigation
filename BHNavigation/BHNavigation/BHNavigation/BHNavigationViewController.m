//
//  BHNavigationViewController.m
//  BHNavigation
//
//  Created by libohao on 15/8/8.
//  Copyright (c) 2015年 libohao. All rights reserved.
//

#import "BHNavigationViewController.h"
#import "UIViewController+BHNavigation.h"
#import "UIView+Accessor.h"
#import "BHNavigationPopAnimation.h"
#import "BHNavigationPushAnimation.h"
#import "BHNavigationBar.h"


@interface BHNavigationViewController ()  <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic, assign) UIViewController *lastViewController;

@property (nonatomic, assign) BOOL isTransiting;

@end

@implementation BHNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        self.enableInnerInactiveGesture = YES;
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.enableInnerInactiveGesture = YES;
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isTransiting = NO;
    
    self.navigationBarHidden = YES;
    
    self.interactivePopGestureRecognizer.delegate = self;
    super.delegate = self;
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    
}

#pragma mark - UINavigationDelegate

// forbid User VC to be NavigationController's delegate
- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
}

#pragma mark - Push & Pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (!self.isTransiting) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self configureNavigationBarForViewController:viewController];
    
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    if (self.isTransiting) {
        self.isTransiting = NO;
        return nil;
    }
    
    return [super popViewControllerAnimated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    self.isTransiting = YES;
    
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
    self.isTransiting = NO;
    
    [viewController.view bringSubviewToFront:viewController.bh_NavigationBar];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (navigationController.viewControllers.count == 1) {
            self.interactivePopGestureRecognizer.delegate = nil;
            self.delegate = nil;
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
    if (self.enableInnerInactiveGesture) {
        BOOL hasPanGesture = NO;
        BOOL hasEdgePanGesture = NO;
        for (UIGestureRecognizer *recognizer in [viewController.view gestureRecognizers]) {
            if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
                if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                    hasEdgePanGesture = YES;
                } else {
                    hasPanGesture = YES;
                }
            }
        }
        if (!hasPanGesture && (navigationController.viewControllers.count > 1)) {
            [viewController.view addGestureRecognizer:self.panRecognizer];
        }
    }
    
    viewController.navigationController.delegate = self;
    
}


// Animation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop && navigationController.viewControllers.count >= 1 && self.enableInnerInactiveGesture) {
        return [[BHNavigationPopAnimation alloc] init];
    } else if (operation == UINavigationControllerOperationPush) {
        BHNavigationPushAnimation *animation = [[BHNavigationPushAnimation alloc] init];
        return animation;
    } else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[BHNavigationPopAnimation class]] && self.enableInnerInactiveGesture) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}


- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer {
    
    static CGFloat startLocationX = 0;

    CGPoint location = [recognizer locationInView:self.view];

    CGFloat progress = (location.x - startLocationX) / [UIScreen mainScreen].bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));

//    NSLog(@"progress:   %.2f", progress);

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocationX = location.x;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {


        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.3) {
            self.interactivePopTransition.completionSpeed = 0.4;
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            self.interactivePopTransition.completionSpeed = 0.3;
            [self.interactivePopTransition cancelInteractiveTransition];
        }

        self.interactivePopTransition = nil;
    }

}

#pragma mark - Private Helper

- (void)configureNavigationBarForViewController:(UIViewController *)viewController {
    
    if (!viewController.bh_NavigationItem) {
        BHNavigationItem *navigationItem = [[BHNavigationItem alloc] init];
        [navigationItem setValue:viewController forKey:@"_bh_viewController"];
        viewController.bh_NavigationItem = navigationItem;
    }
    if (!viewController.bh_NavigationBar) {
        viewController.bh_NavigationBar = [[BHNavigationBar alloc] init];
        [viewController.view addSubview:viewController.bh_NavigationBar];
    }
    
}


@end
