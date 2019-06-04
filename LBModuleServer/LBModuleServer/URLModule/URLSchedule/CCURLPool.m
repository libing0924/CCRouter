//
//  CCURLPool.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLPool.h"

NSString * const CCUrlPoolClassNameKey = @"cc.urlPool.className.key";
NSString * const CCUrlPoolObjectKey = @"cc.urlPool.object.key";
NSString * const CCUrlPoolSelectorKey = @"cc.urlPool.selector.key";
NSString * const CCUrlPoolQueryDesKey = @"cc.urlPool.queryDescription.key";
NSString * const CCUrlPoolNecessityParamKey = @"cc.urlPool.necessity.key";

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
- (void)setURLPoolCapacity:(NSInteger)capacity {
    
}

- (NSDictionary *)infoFromKey:(NSString *)key {
    
    return [self.dataSource objectForKey:key];
}

- (BOOL)addClassName:(nonnull NSString *)className
            queryDes:(NSDictionary<NSString *, NSString *> *)des
         necessities:(NSArray<NSString *> *)necessities
              forKey:(NSString *)key {
    
    if (!className || !key) return NO;
    
    NSMutableDictionary *temp = @{}.mutableCopy;
    [temp setObject:className forKey:CCUrlPoolObjectKey];
    if (des) [temp setObject:des forKey:CCUrlPoolQueryDesKey];
    if (necessities) [temp setObject:necessities forKey:CCUrlPoolNecessityParamKey];
    
    [self.dataSource setObject:temp.copy forKey:key];
    
    return YES;
}

- (BOOL)addObject:(id)object
         selector:(NSString *)selector
         queryDes:(NSDictionary<NSString *, NSString *> *)des
      necessities:(NSArray<NSString *> *)necessities
           forKey:(NSString *)key {
    
    if (!object || !key || !selector) return NO;
    
    NSMutableDictionary *temp = @{}.mutableCopy;
    [temp setObject:object forKey:CCUrlPoolObjectKey];
    [temp setObject:selector forKey:CCUrlPoolSelectorKey];
    if (des) [temp setObject:des forKey:CCUrlPoolQueryDesKey];
    if (necessities) [temp setObject:necessities forKey:CCUrlPoolNecessityParamKey];
    
    
    [self.dataSource setObject:temp.copy forKey:key];
    
    return YES;
}

- (BOOL)removeFromKey:(NSString *)key {
    
    [self.dataSource removeObjectForKey:key];
    
    return YES;
}

@end
