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
    
    NSDictionary *info = [self _infoWithURL:URL];
    
    // 查看传入参数匹配
    NSArray *currentParams = [self _currentParamsFromUrl:URL];
    NSArray *necessities = info[CCUrlPoolNecessityParamKey];
    for (NSString *necessity in necessities) {
        if (![currentParams containsObject:necessity]) return nil;
    }

    // 处理url->class映射
    NSString *className = info[CCUrlPoolClassNameKey];
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
    if ([object conformsToProtocol:@protocol(CCURLProtocol)] && [object respondsToSelector:@selector(willOpenWithURL:fromObject:parameter:)]) {

        isReturn = [object willOpenWithURL:URL fromObject:object parameter:parameters];
    }
    
    BOOL isInject = YES;
    // 协议处理，暂时通过协议业务侧手动处理参数
    if ([object conformsToProtocol:@protocol(CCURLProtocol)] && [object respondsToSelector:@selector(willInjectWithURL:fromObject:parameter:)]) {
        
        isInject = [object willOpenWithURL:URL fromObject:object parameter:parameters];
    }
    if (isInject) {
        // 参数注入，暂不处理参数的自动注入
        
        // 构造器，暂不处理指定构造器的参数注入
    }
    
    if (!isReturn) return nil;
    
    if ([object conformsToProtocol:@protocol(CCURLProtocol)] && [object respondsToSelector:@selector(beenOpenedWithURL:fromObject:parameter:block:)]) {
        
        [object beenOpenedWithURL:URL fromObject:object parameter:parameters block:block];
    }
    
    return object;
}

#pragma mark - private
- (NSDictionary *)_infoWithURL:(NSURL *)URL {
    
    NSString *key = [self _keyWithUrl:URL];
    
    NSDictionary *info = [[CCURLPool shareInstance] infoFromKey:key];
    
    return info;
}

- (NSArray *)_currentParamsFromUrl:(NSURL *)url {
    
    NSMutableArray *necessities = nil;
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *queryItem in components.queryItems) {
        
        if (!necessities) necessities = @[].mutableCopy;
        
        [necessities addObject:queryItem.name];
    }
    
    return necessities;
}

- (NSString *)_keyWithUrl:(NSURL *)url {
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    
    NSString *key = @"";
    
    key = [key stringByAppendingString:components.scheme];
    key = [key stringByAppendingString:components.host];
    key = [key stringByAppendingString:components.path];
    
    return key;
}

@end
