//
//  CCHomeViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCHomeViewController.h"

@interface CCHomeViewController ()

@end

@implementation CCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)switchUserAction:(UIButton *)sender {
    
    [[CCControllerRouter sharedInstance] openRoute:@"ccrouter://rootTabBar?selectedIndex=1" originationController:self];
}

- (IBAction)searchAction:(UIButton *)sender {
    
    [[CCControllerRouter sharedInstance] openRoute:@"ccrouter://homeSearch?keyWord=风衣" originationController:self];
}

- (IBAction)unknowAction:(UIButton *)sender {
    
    [[CCControllerRouter sharedInstance] openRoute:@"ccrouter://unknowController"];
}

@end
