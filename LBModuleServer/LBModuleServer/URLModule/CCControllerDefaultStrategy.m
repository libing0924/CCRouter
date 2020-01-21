//
//  CCControllerDefaultStrategy.m
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/20.
//  Copyright © 2016 李冰. All rights reserved.
//

#import "CCControllerDefaultStrategy.h"

NSString * const CCControllerOpenTypeQueryKey = @"R$OpenType";
NSString * const CCControllerModalStyleQueryKey = @"R$ModalStyle";
NSString * const CCControllerModalAnimationQueryKey = @"R$ModalAnimation";
NSString * const CCControllerPushAnimationQueryKey = @"R$PushAnimation";

@implementation CCControllerRouterRoute

- (NSDictionary *)parametersWithRoute:(NSString *)route {
    
    if ([route containsString:@"?"]) {
        
        NSString *paramtersStr = [route componentsSeparatedByString:@"?"].lastObject;
        NSArray *queryPairs = [paramtersStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *parameters = @{}.mutableCopy;
        for (int i = 0; i < queryPairs.count; i++) {
            
            NSArray *pair = [queryPairs[i] componentsSeparatedByString:@"="];
            [parameters setObject:pair.lastObject forKey:pair.firstObject];
        }
        
        return parameters.copy;
    }
    
    return nil;
}

- (NSString *)routeWithOriginalRoute:(NSString *)route {
    
    return route;
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

@implementation CCControllerRouterOpener

- (void)openDestination:(id)destination origination:(id)origination route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    if ([destination conformsToProtocol:@protocol(CCRouterControllerProtocol)] && [destination respondsToSelector:@selector(routerControllerWillBeOpenedFromController:route:parameters:)]) {
        
        BOOL isOpen = [destination routerControllerWillBeOpenedFromController:origination route:route parameters:parameters];
        if (!isOpen) return;
    }
    
    if (![destination isKindOfClass:UIViewController.class] || ![origination isKindOfClass:UIViewController.class]) {
        return;
    }
    
    CCRouterControllerOpenType openType = [self _openTypeWithDestination:destination origination:origination parameters:parameters];
    
    BOOL animation = YES;
    UIModalPresentationStyle modalStyle = UIModalPresentationFullScreen;
    if (openType == CCRouterControllerOpenTypePush) {
        
        animation = self.pushAnimation;
        NSString *animationValue = [parameters objectForKey:CCControllerPushAnimationQueryKey];
        if (animationValue) animation = (animationValue.integerValue == 0 ? NO : YES);
    } else if (openType == CCRouterControllerOpenTypeModal) {
        
        animation = self.modalAnimation;
        modalStyle = self.modalStyle;
        
        NSString *animationValue = [parameters objectForKey:CCControllerModalAnimationQueryKey];
        if (animationValue) animation = (animationValue.integerValue == 0 ? NO : YES);
        NSString *modalStyleValue = [parameters objectForKey:CCControllerModalStyleQueryKey];
        if (modalStyleValue) modalStyle = modalStyleValue.integerValue;
        
        UINavigationController *presentedNavigationController = nil;
        if ([destination conformsToProtocol:@protocol(CCRouterControllerProtocol)] && [destination respondsToSelector:@selector(navigationControllerWhenPresentedFromController:route:parameters:)]) {
            presentedNavigationController = [(id<CCRouterControllerProtocol>)destination navigationControllerWhenPresentedFromController:origination route:route parameters:parameters];
        }
        
        if (presentedNavigationController) destination = presentedNavigationController;
    }
    
    [self _openDestination:destination origination:origination route:route parameters:parameters type:openType animation:animation modalStyle:modalStyle];
}

- (void)_openDestination:(UIViewController *)destination origination:(UIViewController *)origination route:(NSString *)route parameters:(NSDictionary *)parameters type:(CCRouterControllerOpenType)type animation:(BOOL)animation modalStyle:(UIModalPresentationStyle)modalStyle {
    
    if (type == CCRouterControllerOpenTypePush) {
        
        if ([origination isKindOfClass:UINavigationController.class]) {
            [(UINavigationController *)origination pushViewController:destination animated:animation];
        } else if(origination.navigationController) {
            [origination.navigationController pushViewController:destination animated:animation];
        }
    } else if (type == CCRouterControllerOpenTypeModal) {
        
        destination.modalPresentationStyle = modalStyle;
        [origination presentViewController:destination animated:animation completion:nil];
    }
}

- (CCRouterControllerOpenType)_openTypeWithDestination:(UIViewController *)destination origination:(UIViewController *)origination parameters:(NSDictionary *)parameters {
    
    // Type of globe configuration
    CCRouterControllerOpenType openType = self.openType;
    if (openType == CCRouterControllerOpenTypeAuto) {
        if ([origination isKindOfClass:UINavigationController.class] && ![destination isKindOfClass:UINavigationController.class]) {
            openType = CCRouterControllerOpenTypePush;
        } else {
            openType = CCRouterControllerOpenTypeModal;
        }
    }
    
    // Type of parameter
    NSString *openTypeValue = [parameters objectForKey:CCControllerOpenTypeQueryKey];
    if (openTypeValue) openType = [openTypeValue integerValue];
    
    //  Cast to push when destination is UINavigationController
    if ([destination isKindOfClass:UINavigationController.class]) openType = CCRouterControllerOpenTypeModal;
    
    return openType;
}

@end
