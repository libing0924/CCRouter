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

FOUNDATION_EXTERN NSString * const CCURLRouterIDKey;
FOUNDATION_EXTERN NSString * const CCURLRouterAuthorizationKey;
FOUNDATION_EXTERN NSString * const CCURLRouterCustomParameterKey;

@interface CCURLPool : NSObject

+ (id)shareInstance;

// 加载本地URL池
- (void)loadLocalURLPoolWithPath:(NSString *)path;

// 设置容量默认无上限
- (void)setURLPoolCapacity:(NSInteger)capacity;

// 获取class name
- (NSString *)classNameFromURL:(NSString *)URLStr;

// 获取查询说明
- (NSString *)queryDescriptionFromURL:(NSString *)URLStr;

// 获取object
- (NSDictionary *)objectFromURL:(NSString *)URLStr;

- (BOOL)addClassName:(nonnull NSString *)className URL:(nonnull NSString *)URLStr queryDescription:(NSString *)queryDescription;

- (BOOL)removeClassFromURL:(nonnull NSString *)URLStr;

@end
