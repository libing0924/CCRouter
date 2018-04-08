//
//  LBModuleContext.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//
// 是LBManagerUnit的配置文件，提供全局统一上下文信息

#import <Foundation/Foundation.h>
#import "LBServiceProtocol.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LBEnvironmentType) {
    
    LBEnvironmentDevelop = 0, // 开发
    LBEnvironmentDebug, // 测试
    LBEnvironmentStage, // 演示
    LBEnvironmentRelease // 发布
    
};


@interface LBModuleContext : NSObject <NSCopying>

//global env
@property(nonatomic, assign) LBEnvironmentType env;

//application appkey
@property(nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property(nonatomic, assign) NSInteger customEvent;

@property(nonatomic, strong) UIApplication *application;

@property(nonatomic, strong) NSDictionary *launchOptions;

@property(nonatomic, strong) NSString *moduleConfigName;

@property(nonatomic, strong) NSString *serviceConfigName;

//custom param
@property (nonatomic, copy) NSDictionary *customParam;

+ (instancetype)shareInstance;

/**
 缓存单例服务对象

 @param implInstance 单例对象
 @param serviceName 服务名
 */
- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

/**
 移除缓存

 @param serviceName 服务名
 */
- (void)removeServiceWithServiceName:(NSString *)serviceName;

/**
 获取服务实例

 @param serviceName 服务名
 @return 服务实例
 */
- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end
