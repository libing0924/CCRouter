//
//  CCRouterConfigViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/21.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCRouterConfigViewController.h"
#import "CCPresentedNavigationController.h"

@interface CCRouterConfigViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *pushAnimationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *modalAnimationSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *openTypeSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modalStyleSegment;

@end

@implementation CCRouterConfigViewController

- (UINavigationController *)navigationControllerWhenPresentedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    CCPresentedNavigationController *navi = [[CCPresentedNavigationController alloc] initWithRootViewController:self];
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pushAnimationSwitch.on = [CCControllerRouter sharedInstance].openStrategy.pushAnimation;
    _modalAnimationSwitch.on = [CCControllerRouter sharedInstance].openStrategy.modalAnimation;
    _openTypeSegment.selectedSegmentIndex = [CCControllerRouter sharedInstance].openStrategy.openType;
    if ([CCControllerRouter sharedInstance].openStrategy.modalStyle == UIModalPresentationFullScreen) {
        _modalStyleSegment.selectedSegmentIndex = 1;
    } else {
        _modalStyleSegment.selectedSegmentIndex = 0;
    }
}

- (IBAction)pushAnimationAction:(UISwitch *)sender {
    
    [CCControllerRouter sharedInstance].openStrategy.pushAnimation = sender.on;
}

- (IBAction)modalAnimationAction:(UISwitch *)sender {
    
    [CCControllerRouter sharedInstance].openStrategy.modalAnimation = sender.on;
}

- (IBAction)openTypeAction:(UISegmentedControl *)sender {
    
    [CCControllerRouter sharedInstance].openStrategy.openType = sender.selectedSegmentIndex;
}

- (IBAction)modalStyleAction:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        
        [CCControllerRouter sharedInstance].openStrategy.modalStyle = UIModalPresentationAutomatic;
    } else {
        
        [CCControllerRouter sharedInstance].openStrategy.modalStyle = UIModalPresentationFullScreen;
    }
}

@end
