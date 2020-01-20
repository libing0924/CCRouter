//
//  CCControllerDefaultStrategy.m
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/20.
//  Copyright © 2016 李冰. All rights reserved.
//

#import "CCControllerDefaultStrategy.h"

NSString * const CCControllerOpenTypeQueryKey = @"routerOpenType";

CCControllerOpenType const CCControllerOpenTypePush = @"routerOpenWithPush";
CCControllerOpenType const CCControllerOpenTypePresent = @"routerOpenWithPresent";

@implementation CCControllerRouterOpener

- (void)openDestination:(id)destination origination:(id)origination route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    if ([destination conformsToProtocol:@protocol(CCRouterControllerProtocol)] && [destination respondsToSelector:@selector(routerControllerWillBeOpenedFromController:route:parameters:)]) {
        
        BOOL isOpen = [destination routerControllerWillBeOpenedFromController:origination route:route parameters:parameters];
        
        if (!isOpen) return;
    }
    
    if (![destination isKindOfClass:UIViewController.class] || ![origination isKindOfClass:UIViewController.class]) {
        return;
    }
    
    CCControllerOpenType openType = CCControllerOpenTypePresent;
    
    if ([origination isKindOfClass:UINavigationController.class] && ![destination isKindOfClass:UINavigationController.class]) {
        
        openType = CCControllerOpenTypePush;
    }
    
    [self _openDestination:destination origination:origination route:route parameters:parameters type:openType];
}

- (void)_openDestination:(UIViewController *)destination origination:(UIViewController *)origination route:(NSString *)route parameters:(NSDictionary *)parameters type:(CCControllerOpenType)type {
    
    if (type == CCControllerOpenTypePush) {
        
        if ([origination isKindOfClass:UINavigationController.class]) {
            [(UINavigationController *)origination pushViewController:destination animated:YES];
        } else if(origination.navigationController) {
            [origination.navigationController pushViewController:destination animated:YES];
        }
    } else if (type == CCControllerOpenTypePresent) {
        
        [origination presentViewController:destination animated:YES completion:nil];
    }
}

@end

@implementation CCControllerRouterRoute

- (NSDictionary *)parametersWithRoute:(NSString *)route {
    
    NSString *paramtersStr = [route componentsSeparatedByString:@"?"].lastObject;
    NSArray *queryPairs = [paramtersStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = @{}.mutableCopy;
    for (int i = 0; i < queryPairs.count; i++) {
        
        NSArray *pair = [queryPairs[i] componentsSeparatedByString:@"="];
        [parameters setObject:pair.lastObject forKey:pair.firstObject];
    }
    
    return parameters.copy;
}

- (NSString *)routeWithOriginalRoute:(NSString *)route {
    
    return [route componentsSeparatedByString:@"?"].firstObject;
}

@end

@implementation CCControllerRouterGenerator

- (id)generateOriginationWithOriginalOrigination:(id)originalOrigination route:(NSString *)route {
    
    if (!originalOrigination && ![originalOrigination isKindOfClass:UIViewController.class]) {
        
        originalOrigination = [self activeController];
    }
    
    return originalOrigination;
}

- (id)generateDestinationWithClass:(Class)cls route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    UIViewController *destinationController = nil;
    
    if ([cls conformsToProtocol:@protocol(CCRouterControllerProtocol)] && [cls respondsToSelector:@selector(routerControllerWillBeInitiatedRoute:parameters:)]) {
        destinationController = [cls routerControllerWillBeInitiatedRoute:route parameters:parameters];
    } else {
        destinationController = [[cls alloc] init];
    }
    
    if (![destinationController isKindOfClass:UIViewController.class]) {
        destinationController = nil;
    }
    
    return destinationController;
}

/// The top controller of window
- (UIViewController *)activeController {
    
     UIWindow *window = [[UIApplication sharedApplication].delegate window];
       UIViewController *topViewController = [window rootViewController];
       
       while (true) {
           
           if (topViewController.presentedViewController) {
               
               topViewController = topViewController.presentedViewController;
               
           } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
               
               topViewController = [(UINavigationController *)topViewController topViewController];
               
           } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
               
               UITabBarController *tab = (UITabBarController *)topViewController;
               topViewController = tab.selectedViewController;
               
           } else {
               break;
           }
       }
       return topViewController;
}

@end
