//
//  CCURLPool.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLPool.h"

NSString * const CCUrlPoolClassNameKey = @"cc.urlPool.className.key";

NSString * const CCUrlPoolQueryDesKey = @"cc.urlPool.queryDescription.key";

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

// 暂不实现
- (void)loadLocalURLPoolWithPath:(NSString *)path {
    
}

// 暂不实现
- (void)setURLPoolCapacity:(NSInteger)capacity {
    
}

- (NSDictionary *)infoFromURL:(NSString *)URLStr {
    
    if (!URLStr) return nil;
    
    NSDictionary *object = [self.dataSource objectForKey:URLStr];
    
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return object;
}

- (BOOL)addClassName:(NSString *)className URL:(NSString *)URLStr queryDescription:(NSString *)queryDescription{
    
    if (!className || !URLStr) return NO;
    
    NSDictionary *object = [NSDictionary dictionaryWithObjects:@[className, queryDescription]
                                                       forKeys:@[CCUrlPoolClassNameKey, CCUrlPoolQueryDesKey]];
    
    [self.dataSource setObject:object forKey:URLStr];
    
    return YES;
}

- (BOOL)removeFromURL:(NSString *)URL {
    
    [self.dataSource removeObjectForKey:URL];
    
    return YES;
}

@end
