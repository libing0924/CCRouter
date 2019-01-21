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

@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation CCURLRegister

//{url:@"";className:@"";parameterDes:@""}
- (BOOL)registerLocalWithPath:(NSString *)path {
    
    return YES;
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className {
    
    return [self registerURL:URL calssName:className queryDescription:URL.query];
}

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDescription:(NSString *)queryDescription {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:URL_QUERY_DELIMITER].firstObject;
    
    // verify exist
    NSDictionary *data = [self dataFromURL:key];
    if (data) return NO;
    
    return [self _addClassName:className URL:key queryDescription:queryDescription];
}

- (BOOL)unregisterURL:(NSURL *)URL calssName:(NSString *)className {
    
    NSString *key = [URL.absoluteString componentsSeparatedByString:URL_QUERY_DELIMITER].firstObject;
    
    // verify not exist
    NSDictionary *data = [self dataFromURL:key];
    if (!data) return NO;
    
    return [self _removeClassFromURL:key];
}

- (NSDictionary *)dataFromURL:(NSString *)URLStr {
    
    if (!URLStr) return nil;
    
    NSDictionary *object = [self.dataSource objectForKey:URLStr];
    
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return object;
}

#pragma mark - private method

- (BOOL)_addClassName:(NSString *)className URL:(NSString *)URLStr queryDescription:(NSString *)queryDescription{
    
    if (!className || !URLStr) return NO;
    
    NSDictionary *object = [NSDictionary dictionaryWithObjects:@[className, queryDescription] forKeys:@[CC_URLPOOL_CLASS_NAME_KEY, CC_URLPOOL_QUERY_DES_KEY]];
    
    [self.dataSource setObject:object forKey:URLStr];
    
    return YES;
}

- (BOOL)_removeClassFromURL:(NSString *)URL {
    
    [self.dataSource removeObjectForKey:URL];
    
    return YES;
}


@end
