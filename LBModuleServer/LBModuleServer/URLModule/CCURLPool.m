//
//  CCURLPool.m
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLPool.h"

NSString * const CCURLRouterOpenMethodPush = @"openMethodPush";

NSString * const CCURLRouterOpenMethodPresent = @"openMethodPresent";

NSString * const CCURLRouterIDKey = @"ID";

NSString * const CCURLRouterOpenMethodKey = @"openMethod";

NSString * const CCURLRouterAuthorizationKey = @"authorization";

NSString * const CCURLRouterCustomParameterKey = @"customParameter";

#define CC_URLPOOL_CLASS_NAME_KEY @"cc.urlPool.className.key"

#define CC_URLPOOL_QUERY_DES_KEY @"cc.urlPool.queryDescription.key"

@interface CCURLPool ()

@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation CCURLPool

+ (id)shareInstance {
    
    static CCURLPool *pool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        pool = [[CCURLPool alloc] init];
    });
    
    return pool;
}

- (void)loadLocalURLPoolWithPath:(NSString *)path {
    
}

- (void)setURLPoolCapacity:(NSInteger)capacity {
    
}

- (NSString *)classNameFromURL:(NSString *)URLStr {
    
    NSDictionary *object = [self objectFromURL:URLStr];
    
    if (!object) return nil;
    
    NSString *className = [object objectForKey:CC_URLPOOL_CLASS_NAME_KEY];
    
    return className;
}

- (NSString *)queryDescriptionFromURL:(NSString *)URLStr {
    
    
    NSDictionary *object = [self objectFromURL:URLStr];
    
    if (!object) return nil;
    
    NSString *className = [object objectForKey:CC_URLPOOL_CLASS_NAME_KEY];
    
    return className;
}

- (NSDictionary *)objectFromURL:(NSString *)URLStr {
    
    if (!URLStr) return nil;
    
    NSDictionary *object = [self.dataSource objectForKey:URLStr];
    
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return object;
}

- (BOOL)addClassName:(NSString *)className URL:(NSString *)URLStr queryDescription:(NSString *)queryDescription{
    
    if (!className || !URLStr) return NO;
    
    NSDictionary *object = [NSDictionary dictionaryWithObjects:@[className, queryDescription] forKeys:@[CC_URLPOOL_CLASS_NAME_KEY, CC_URLPOOL_QUERY_DES_KEY]];
    
    [self.dataSource setObject:object forKey:URLStr];
    
    return YES;
}

- (BOOL)removeClassFromURL:(NSString *)URL {
    
    [self.dataSource removeObjectForKey:URL];
    
    return YES;
}

@end
