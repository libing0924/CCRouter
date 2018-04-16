//
//  CCURLRegister.m
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLRegister.h"
#import "CCURLPool.h"

@implementation CCURLRegister

//{url:@"";className:@"";parameterDes:@""}
- (BOOL)registerLocalWithPath:(NSString *)path {
    
    return YES;
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className {
    
    
    return [self registerURL:URL calssName:className queryDescription:URL.query];
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDescription:(NSString *)queryDescription {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:@"?"].firstObject;
    
    // verify exist
    NSString *tmpClassName = [[CCURLPool shareInstance] classNameFromURL:key];
    if (tmpClassName) return NO;
    
    return [[CCURLPool shareInstance] addClassName:className URL:key queryDescription:queryDescription];
}

- (BOOL)unregisterURL:(NSURL *)URL calssName:(NSString *)className {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:@"?"].firstObject;
    
    // verify not exist
    NSString *tmpClassName = [[CCURLPool shareInstance] classNameFromURL:key];
    if (!tmpClassName) return NO;
    
    return [[CCURLPool shareInstance] removeClassFromURL:key];
}

@end
