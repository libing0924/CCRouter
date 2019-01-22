//
//  CCURLRegister.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLRegister.h"
#import "CCURLPool.h"

@interface CCURLRegister ()

@end

@implementation CCURLRegister

- (BOOL)registerURLWithLocalPath:(NSString *)path {
    
    return YES;
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDes:(NSDictionary<NSString *, NSString *> *)des {
    
    if (!className) return NO;
    
    NSString *key = [self _keyWithUrl:URL];
    if (!key.length) return NO;
    
    NSDictionary *data = [[CCURLPool shareInstance] infoFromURL:key];
    if (data) return NO;
    
    NSArray *necessities = [self _necessitiesFromUrl:URL];
    
    return [[CCURLPool shareInstance] addClassName:className queryDes:des necessities:necessities forKey:key];
}

- (BOOL)registerURL:(NSURL *)URL object:(id)object selector:(NSString *)selector queryDes:(NSDictionary<NSString *, NSString *> *)des {
    
    if (!object || !selector) return NO;
    
    NSString *key = [self _keyWithUrl:URL];
    if (!key.length) return NO;
    
    NSDictionary *data = [[CCURLPool shareInstance] infoFromURL:key];
    if (data) return NO;
    
    NSArray *necessities = [self _necessitiesFromUrl:URL];
    
    return [[CCURLPool shareInstance] addObject:object selector:selector queryDes:des necessities:necessities forKey:key];
}

#pragma mark - private
- (NSArray *)_necessitiesFromUrl:(NSURL *)url {
    
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
