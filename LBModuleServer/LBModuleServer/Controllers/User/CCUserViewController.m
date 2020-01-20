//
//  CCUserViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCUserViewController.h"

@interface CCUserViewController ()

@end

@implementation CCUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)switchHomeAction:(UIButton *)sender {
    
    [[CCControllerRouter sharedInstance] openRoute:@"ccrouter://rootTabBar?selectedIndex=0" originationController:self];
}

- (IBAction)profileAction:(UIButton *)sender {
    
    [[CCControllerRouter sharedInstance] openRoute:@"ccrouter://userProfile?userName=Li" originationController:self.navigationController];
}

@end
