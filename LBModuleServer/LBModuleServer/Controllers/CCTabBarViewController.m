//
//  CCTabBarViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCTabBarViewController.h"

#import "CCNavigationViewController.h"
#import "CCUserViewController.h"
#import "CCHomeViewController.h"

@interface CCTabBarViewController ()

@end

@implementation CCTabBarViewController

+ (UIViewController *)routerControllerWillBeInitiatedRoute:(NSString *)route parameters:(NSDictionary *)parameters {
    
    if ([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:CCTabBarViewController.class]) {
        
        return UIApplication.sharedApplication.keyWindow.rootViewController;
    }
    
    return nil;
}

- (BOOL)routerControllerWillBeOpenedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    NSNumber *selectedIndex = parameters[@"selectedIndex"];
    NSInteger selected = selectedIndex.integerValue;
    [self setSelectedIndex:selected];
    
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CCHomeViewController *home = [[CCHomeViewController alloc] init];
    home.title = @"Home";
    CCNavigationViewController *homeNavi = [[CCNavigationViewController alloc] initWithRootViewController:home];
    
    CCUserViewController *user = [[CCUserViewController alloc] init];
    user.title = @"User";
    CCNavigationViewController *userNavi = [[CCNavigationViewController alloc] initWithRootViewController:user];
    
    self.viewControllers = @[homeNavi, userNavi];
}

@end
