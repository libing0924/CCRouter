//
//  CCURLRouter.m
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLRouter.h"
#import "CCURLPool.h"

NSString * const CCURLRouterOpenMethodPush = @"cc.urlModule.openMethod.push";

NSString * const CCURLRouterOpenMethodPresent = @"cc.urlModule.openMethod.present";

@implementation CCURLRouter

- (BOOL)openURL:(NSURL *)URL {
    
    return [self openURL:URL customParameter:nil];
    
}

- (BOOL)openURL:(NSURL *)URL customParameter:(NSDictionary *)parameter {
    
    return [self openURL:URL openMethod:nil authorization:nil ID:nil customParameter:parameter];
}

- (BOOL)openURL:(NSURL *)URL openMethod:(NSString *)openMethod authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter {
    
    if (!URL) return NO;
    
    // 参数处理
    // 协议处理
    
    return YES;
}

- (NSString *)classNameWithURL:(NSURL *)URL {
    
    return nil;
}

@end
