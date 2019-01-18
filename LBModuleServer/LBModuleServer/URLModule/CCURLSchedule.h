//
//  CCURLSchedule.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//


// CCURLRouterIDKey、CCURLRouterAuthorizationKey、CCURLRouterCustomParameterKey默认是本框架的逻辑层参数key，CCURLRouterCustomParameterKey所对应的是JSON object业务层参数，建议扩展还是采用本规则，query层传递逻辑层参数，业务层参数进行二次包装;

#import <Foundation/Foundation.h>
#import "CCURLProtocol.h"

@interface CCURLSchedule : NSObject

+ (id)shareInstance;

// 通过本地配置文件注册映射表
- (BOOL)registerLocalURLWithPath:(NSString *)path;
// 注册单个class的映射关系
- (BOOL)registerURL:(NSString *)URLStr calss:(Class)className;
// 注册单个class的映射关系并添加传入参数说明
- (BOOL)registerURL:(NSString *)URL calssName:(Class)className queryDescription:(NSString *)queryDescription;
// 取消注册
- (BOOL)unregisterURL:(NSString *)URLStr calss:(Class)className;

- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject;
- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject customParameter:(NSDictionary *)parameter;

- (id)objectFromURL:(NSString *)URLStr customParameter:(NSDictionary *)parameter;
- (Class)classFromURL:(NSString *)URLStr;

@end
