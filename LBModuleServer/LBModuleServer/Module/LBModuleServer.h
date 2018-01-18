//
//  LBManagerUnit.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/4.
//  Copyright © 2017年 李冰. All rights reserved.
//
// 基于阿里巴巴BeeHive框架的思想的组件化框架
// Spring https://www.ibm.com/developerworks/cn/java/wa-spring1/
// Apache AOP http://httpd.apache.org/docs/current/dso.html
// Cocoapods https://cocoapods.org

// 分为LBModuleManager模块管理类，LBServiceManager服务管理类
// LBModuleManager模块管理主要负责提供各个模块的事件管理，系统事件、通用事件、自定义事件。各模块需要定义一个用于模块管理的类，整合模块内的事件分发和事件处理等。
// LBServiceManager服务管理主要负责各个模块的能提供的能力管理， 能力则由protocol申明，这里其他模块与protocol耦合

// 基础模块
// LBURLModule主要用于view controller的URL router设计跳转，解上面protocol导致的耦合

#import <Foundation/Foundation.h>
#import "LBModuleProtocol.h"
#import "LBModuleContext.h"
//#import "BHAppDelegate.h"
#import "LBModuleManager.h"
#import "LBServiceManager.h"

@interface LBModuleServer : NSObject

//程序运行全局的上下文
@property(nonatomic, strong) LBModuleContext *context;

// 开启异常信息
@property (nonatomic, assign) BOOL enableException;

// 单例方法
+ (instancetype)shareInstance;

// 注册模块
+ (void)registerDynamicModule:(Class) moduleClass;

// 创建提供服务的对象
- (id)createService:(Protocol *)proto;

// 注册服务和提供服务的类
- (void)registerService:(Protocol *)proto service:(Class) serviceClass;

// 触发自定义事件
+ (void)triggerCustomEvent:(NSInteger)eventType;

@end
