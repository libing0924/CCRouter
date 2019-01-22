//
//  CCURLPool.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

// 管理URL池，包括对池的增/删操作、缓存、本地数据处理

#import <Foundation/Foundation.h>

#define URL_QUERY_DELIMITER @"?"
#define URL_QUERY_PAIR_DELIMITER @"&"
#define URL_QUERY_KEY_VALUE_DELIMITER @"="

FOUNDATION_EXTERN NSString * const CCUrlPoolClassNameKey;
FOUNDATION_EXTERN NSString * const CCUrlPoolObjectKey;
FOUNDATION_EXTERN NSString * const CCUrlPoolSelectorKey;
FOUNDATION_EXTERN NSString * const CCUrlPoolQueryDesKey;
FOUNDATION_EXTERN NSString * const CCUrlPoolNecessityParamKey;

@interface CCURLPool : NSObject

+ (id)shareInstance;

// 获取一个注册项{CCUrlPoolClassNameKey:object, CCUrlPoolQueryDesKey:object}
- (NSDictionary *)infoFromKey:(NSString *)key;

// 添加一个注册项
- (BOOL)addClassName:(nonnull NSString *)className
            queryDes:(NSDictionary<NSString *, NSString *> *)des
         necessities:(NSArray<NSString *> *)necessities
              forKey:(NSString *)key;

- (BOOL)addObject:(nonnull id)object
         selector:(NSString *)selector
         queryDes:(NSDictionary<NSString *, NSString *> *)des
      necessities:(NSArray<NSString *> *)necessities
           forKey:(NSString *)key;

// 移除
- (BOOL)removeFromKey:(nonnull NSString *)key;

@end
