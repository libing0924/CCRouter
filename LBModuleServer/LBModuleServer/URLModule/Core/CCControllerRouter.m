//
//  CCControllerRouter.m
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/9.
//  Copyright © 2016 李冰. All rights reserved.
//

#import "CCControllerRouter.h"

@implementation CCControllerRouter

+ (instancetype)sharedInstance {
    
    static CCControllerRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        router = [[CCControllerRouter alloc] init];
    });
    
    return router;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        _routeMap = @{}.mutableCopy;
        _openStrategy = [[CCControllerRouterOpener alloc] init];
        _routeStrategy = [[CCControllerRouterRoute alloc] init];
        _generatorStrategy = [[CCControllerRouterGenerator alloc] init];
    }
    
    return self;
}

- (Class)classWithRoute:(NSString * _Nonnull)routerString {
    
    NSString *className = [self.routeMap objectForKey:routerString];
    
    Class cls = NSClassFromString(className);

    return cls;
}

- (void)registerRoute:(NSString * _Nonnull)route className:(NSString * _Nonnull)className {
    
    [self.routeMap setObject:className forKey:route];
}

- (void)openRoute:(NSString * _Nonnull)route {
    
    [self openRoute:route originationController:nil];
}

- (void)openRoute:(NSString * _Nonnull)route originationController:(UIViewController *)originationController {
    
    NSString *pureRoute = nil;
    if ([self.routeStrategy respondsToSelector:@selector(routeWithOriginalRoute:)]) {
        pureRoute = [self.routeStrategy routeWithOriginalRoute:route];
    }
    
    if (!pureRoute) return;
    
    if ([self.generatorStrategy respondsToSelector:@selector(generateOriginationWithOriginalOrigination:route:)]) {
        originationController = [self.generatorStrategy generateOriginationWithOriginalOrigination:originationController route:route];
    }
    
    if (!originationController) return;
    
    Class cls = [self classWithRoute:pureRoute];
    
    if (!cls) return;
    
    NSDictionary *parameters = [self.routeStrategy parametersWithRoute:route];
    
    UIViewController *destinationController = [self.generatorStrategy generateDestinationWithClass:cls route:pureRoute parameters:parameters];
    
    if (!destinationController) return;
    
    [self.openStrategy openDestination:destinationController origination:originationController route:pureRoute parameters:parameters];
}

@end
