//
//  CCPresentedNavigationController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/21.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCPresentedNavigationController.h"

@interface CCPresentedNavigationController ()

@end

@implementation CCPresentedNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    if (self = [super initWithRootViewController:rootViewController]) {
        
        [self _configBackButtonWithController:rootViewController];
    }
    
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        [self _configBackButtonWithController:viewController];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)_configBackButtonWithController:(UIViewController *)controller {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backAction:(UIButton *)sender {
    
    if (self.viewControllers.count == 1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
     
        [self popViewControllerAnimated:YES];
    }
}

@end
