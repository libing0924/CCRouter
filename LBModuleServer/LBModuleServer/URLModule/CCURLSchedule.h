//
//  CCURLSchedule.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

// CCURLRouterIDKey、CCURLRouterAuthorizationKey、CCURLRouterCustomParameterKey默认是本框架的逻辑层参数key，CCURLRouterCustomParameterKey所对应的是JSON object业务层参数，建议扩展还是采用本规则，query层传递逻辑层参数，业务层参数进行二次包装;

#import <Foundation/Foundation.h>
#import "CCURLProtocol.h"


@interface CCURLSchedule : NSObject

+ (id)shareInstance;

- (BOOL)registerLocalURLWithPath:(NSString *)path;
- (BOOL)registerURL:(NSString *)URLStr calss:(Class)className;
- (BOOL)registerURL:(NSString *)URL calssName:(Class)className queryDescription:(NSString *)queryDescription;
- (BOOL)unregisterURL:(NSString *)URLStr calss:(Class)className;

- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject;
- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject customParameter:(NSDictionary *)parameter;
- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter;

- (id)objectFromURL:(NSString *)URLStr customParameter:(NSDictionary *)parameter;
- (Class)classFromURL:(NSString *)URLStr;

@end
