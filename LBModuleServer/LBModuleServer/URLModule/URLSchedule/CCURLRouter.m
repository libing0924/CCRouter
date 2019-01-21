//
//  CCURLRouter.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLRouter.h"
#import "CCURLPool.h"
#import "CCURLProtocol.h"

@implementation CCURLRouter

- (id)openURL:(NSURL *)URL fromObject:(id)fromObject {
    
    return [self openURL:URL fromObject:fromObject block:nil];
}

- (id)openURL:(NSURL *)URL fromObject:(id)fromObject block:(void (^)(NSDictionary *))block {
    
    NSString *className = [self classNameWithURL:URL];
    Class class = NSClassFromString(className);
    if (!class) return nil;
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:NO];
    NSMutableDictionary *parameters =@{}.mutableCopy;
    for (NSURLQueryItem *queryItem in urlComponents.queryItems) {
        
        [parameters setObject:queryItem.value forKey:queryItem.name];
    }
    
    id object = [[class alloc] init];
    BOOL isReturn = YES;
    // 协议处理，暂时通过协议业务侧手动处理参数
    if ([object conformsToProtocol:@protocol(CCURLProtocol)]) {
        
        if ([object respondsToSelector:@selector(willBeOpenedWithURL:fromObject:parameter:)]) {
            
            isReturn = [object willBeOpenedWithURL:URL fromObject:object parameter:parameters];
        }
    }
    
    // 参数处理，暂不处理参数的自动注入
    
    // 构造器，暂不处理指定构造器的参数注入
    
    if (!isReturn) return nil;
    
    if ([object conformsToProtocol:@protocol(CCURLProtocol)]) {
        
        if ([object respondsToSelector:@selector(hasBeenOpenedWithURL:fromObject:parameter:block:)]) {
            
            [object hasBeenOpenedWithURL:URL fromObject:object parameter:parameters block:block];
        }
    }
    
    return object;
}

@end
