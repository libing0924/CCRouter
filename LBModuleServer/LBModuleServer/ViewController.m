//
//  ViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CCRouterControllerProtocol>

@end

@implementation ViewController


+ (UIViewController *)controllerWillBeInitiatedRouterString:(NSString *)routerString {
    
    BOOL isLogin = YES;
    if (isLogin) {
        
        return nil;
    }
    
    return nil;
}

- (void)controllerDidBeInitiatedRouterString:(NSString *)routerString parameters:(NSDictionary *)parameters {
    
    
}

- (void)controllerWillBeOpenedRouterString:(NSString *)routerString fromController:(UIViewController *)fromController {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
