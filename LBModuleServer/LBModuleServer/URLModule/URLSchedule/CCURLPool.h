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

FOUNDATION_EXTERN NSString * const CCUrlPoolQueryDesKey;

@interface CCURLPool : NSObject

+ (id)shareInstance;

// 加载本地URL池
- (void)loadLocalURLPoolWithPath:(NSString *)path;

// 获取一个注册项{CCUrlPoolClassNameKey:object, CCUrlPoolQueryDesKey:object}
- (NSDictionary *)infoFromURL:(NSString *)URLStr;

// 添加一个注册项
- (BOOL)addClassName:(nonnull NSString *)className URL:(nonnull NSString *)URLStr queryDescription:(NSString *)queryDescription;

// 移除
- (BOOL)removeFromURL:(nonnull NSString *)URLStr;

@end
