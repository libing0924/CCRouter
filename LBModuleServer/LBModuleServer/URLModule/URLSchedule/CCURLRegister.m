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

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className {
    
    return [self registerURL:URL calssName:className queryDescription:URL.query];
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDescription:(NSString *)queryDescription {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:URL_QUERY_DELIMITER].firstObject;
    
    NSDictionary *data = [[CCURLPool shareInstance] infoFromURL:key];
    if (data) return NO;
    
    return [self _addClassName:className URL:key queryDescription:queryDescription];
}

#pragma mark - private method

- (BOOL)_addClassName:(NSString *)className URL:(NSString *)URLStr queryDescription:(NSString *)queryDescription{
    
    if (!className || !URLStr) return NO;
    
    return [[CCURLPool shareInstance] addClassName:className URL:URLStr queryDescription:queryDescription];
}

- (BOOL)_removeClassFromURL:(NSString *)URL {
    
    return [[CCURLPool shareInstance] removeFromURL:URL];
}

@end
