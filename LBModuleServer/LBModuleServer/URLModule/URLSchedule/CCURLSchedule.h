//
//  CCURLSchedule.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//


// CCURLRouterIDKey、CCURLRouterAuthorizationKey、CCURLRouterCustomParameterKey默认是本框架的逻辑层参数key，CCURLRouterCustomParameterKey所对应的是JSON object业务层参数，建议扩展还是采用本规则，query层传递逻辑层参数，业务层参数进行二次包装;

#import <Foundation/Foundation.h>
#import "CCURLPool.h"
#import "CCURLProtocol.h"
#import "CCURLRouterWildcardProtocol.h"

@interface CCURLSchedule : NSObject

@property (nonatomic, strong) id<CCURLRouterWildcardProtocol> wildcardDelegate;

+ (id)shareInstance;

// 通过本地配置文件注册映射表
- (BOOL)registerURLWithLocalPath:(NSString *)path;

// 注册的时候跟的query默认为采用key=?的形式，如果openw的时候未带有和key匹配的参数则不能open
// 注册url->class的映射
- (BOOL)registerURL:(NSString *)urlStr calssName:(NSString *)className;
- (BOOL)registerURL:(NSString *)urlStr calssName:(NSString *)className queryDes:(NSDictionary<NSString *, NSString *> *)des;
// 注册url->函数的映射
- (BOOL)registerURL:(NSString *)urlStr object:(id)object selector:(NSString *)selector;
- (BOOL)registerURL:(NSString *)urlStr object:(id)object selector:(NSString *)selector queryDes:(NSDictionary<NSString *, NSString *> *)des;

// 打开一个链接
- (id)openURL:(NSString *)urlStr fromObject:(id)fromObject;
// 打开一个链接并传递一个函数过来
- (id)openURL:(NSString *)urlStr fromObject:(id)fromObject block:(void(^)(NSDictionary *parameter))block;

// 根据url返回注册信息
- (NSDictionary *)infoFromURL:(NSString *)urlStr;

@end
