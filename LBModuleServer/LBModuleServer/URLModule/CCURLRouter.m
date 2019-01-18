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
    
    return [self openURL:URL fromObject:fromObject customParameter:nil];
}

- (id)openURL:(NSURL *)URL fromObject:(id)fromObject customParameter:(NSDictionary *)parameter {
    
    if (!URL) return nil;
    
    NSString *className = [self classNameWithURL:URL];
    Class class = NSClassFromString(className);
    if (!class) return nil;
    
    // URL 跟随了查询语句
    NSDictionary *systemParameter = nil;
    if ([URL.absoluteString containsString:URL_QUERY_DELIMITER])
    {
        NSMutableDictionary *queryParameter = [self _queryToDictonary:URL.query];
        
        if ([queryParameter objectForKey:CCURLRouterCustomParameterKey])
        {
            NSString *parameterStr = [queryParameter objectForKey:CCURLRouterCustomParameterKey];
            
            parameter = [NSJSONSerialization JSONObjectWithData:[parameterStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            [queryParameter removeObjectForKey:CCURLRouterCustomParameterKey];
        }
        
        systemParameter = queryParameter.copy;
    }
    
    id object = [[class alloc] init];
    BOOL isReturn = YES;
    // 协议处理，暂时通过协议业务侧手动处理参数
    if ([object conformsToProtocol:@protocol(CCURLProtocol)])
    {
        if ([object respondsToSelector:@selector(willBeOpenedWithURL:fromObject:systemParameter:customParameter:)])
        {
            isReturn = [object willBeOpenedWithURL:URL fromObject:object systemParameter:systemParameter customParameter:parameter];
        }
        
        if ([object respondsToSelector:@selector(hasBeenOpenedWithURL:fromObject:systemParameter:customParameter:)])
        {
            [object hasBeenOpenedWithURL:URL fromObject:object systemParameter:systemParameter customParameter:parameter];
        }
    }
    
    // 参数处理，暂不处理参数的自动注入
    
    // 构造器，暂不处理指定构造器的参数注入
    
    if (!isReturn) return nil;
    
    return object;
}

- (NSString *)classNameWithURL:(NSURL *)URL {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:URL_QUERY_DELIMITER].firstObject;
    
    return [[CCURLPool shareInstance] classNameFromURL:key];
}

#pragma mark - privaty method
- (NSMutableDictionary *)_queryToDictonary:(NSString *)query {
    
    NSArray *pairs = [query componentsSeparatedByString:URL_QUERY_PAIR_DELIMITER];
    
    NSMutableDictionary *mutDic = [NSMutableDictionary new];
    
    for (NSString *pair in pairs)
    {
        NSArray *keyAndValue = [pair componentsSeparatedByString:URL_QUERY_KEY_VALUE_DELIMITER];
        
        if (keyAndValue.count != 2) continue;
        
        [mutDic setObject:keyAndValue.lastObject forKey:keyAndValue.firstObject];
    }
    
    if (mutDic.count > 0) return mutDic;
    
    return nil;
}

@end
