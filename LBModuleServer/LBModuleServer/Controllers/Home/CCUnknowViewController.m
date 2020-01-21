//
//  CCUnknowViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCUnknowViewController.h"
#import "CCPresentedNavigationController.h"

@interface CCUnknowViewController ()

@end

@implementation CCUnknowViewController

- (UINavigationController *)navigationControllerWhenPresentedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    CCPresentedNavigationController *navi = [[CCPresentedNavigationController alloc] initWithRootViewController:self];
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
