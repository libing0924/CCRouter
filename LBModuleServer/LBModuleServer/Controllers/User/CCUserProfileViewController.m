//
//  CCUserProfileViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCUserProfileViewController.h"

@interface CCUserProfileViewController () {
    
    NSString *_userNameString;
}

@property (weak, nonatomic) IBOutlet UILabel *userName;

@end

@implementation CCUserProfileViewController

- (BOOL)routerControllerWillBeOpenedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    _userNameString = parameters[@"userName"];
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userName.text = _userNameString;
}

@end
