//
//  LBServiceManager.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/4.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LB_SERVICE_MANAGER

@class LBModuleContext;

@interface LBServiceManager : NSObject

@property (nonatomic, assign) BOOL  enableException;

+ (instancetype)sharedManager;

/**
 根据配置文件绑定服务和类
 */
- (void)registerLocalServices;

/**
 绑定服务和实现该服务的类

 @param service 服务名
 @param implClass 实现服务的类
 */
- (void)registerService:(Protocol *)service implClass:(Class)implClass;

/**
 根据服务返回该服务的实现类的实例对象

 @param service 服务名
 @return 实例对象(可能为单例类或者非单例类的实例对象)
 */
- (id)createService:(Protocol *)service;

/**
 根据服务查找该服务的实现类（主要用于服务定义了带入参数的初始化方法）

 @param service 服务名
 @return 提供服务的实现类
 */
- (Class)createServiceClass:(Protocol *)service;

@end
