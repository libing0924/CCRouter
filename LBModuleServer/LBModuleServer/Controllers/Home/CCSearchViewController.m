//
//  CCSearchViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCSearchViewController.h"
#import "CCNavigationViewController.h"

@interface CCSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CCSearchViewController {
    
    NSString *_defaultKeyWord;
}

+ (UIViewController *)routerControllerWillBeInitiatedRoute:(NSString *)route parameters:(NSDictionary *)parameters {
    
    CCSearchViewController *search = [CCSearchViewController new];
    search->_defaultKeyWord = parameters[@"keyWord"];
    CCNavigationViewController *navi = [[CCNavigationViewController alloc] initWithRootViewController:search];
    
    return navi;
}

// This method not be called
- (BOOL)routerControllerWillBeOpenedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    _defaultKeyWord = parameters[@"keyWord"];
    NSLog(@"Call this method.");
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.text = _defaultKeyWord;
}

- (IBAction)backAction:(UIButton *)sender {
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.firstObject == self) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
