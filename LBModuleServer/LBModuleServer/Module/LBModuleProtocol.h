//
//  LBModuleProtocol.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//

// 提供模块处理系统和通用事件的能力

#import <Foundation/Foundation.h>
@class LBModuleContext;
@class LBManagerUnit;

#define BH_EXPORT_MODULE(isAsync) \
+ (void)load { [LBManagerUnit registerDynamicModule:[self class]]; } \
-(BOOL)async { return [[NSString stringWithUTF8String:#isAsync] boolValue];}


@protocol LBModuleProtocol <NSObject>


@optional

//如果不去设置Level默认是Normal
//basicModuleLevel不去实现默认Normal
- (void)basicModuleLevel;
//越大越优先
- (NSInteger)modulePriority;

- (BOOL)async;

- (void)modSetUp:(LBModuleContext *)context;

- (void)modInit:(LBModuleContext *)context;

- (void)modSplash:(LBModuleContext *)context;

- (void)modQuickAction:(LBModuleContext *)context;

- (void)modTearDown:(LBModuleContext *)context;

- (void)modWillResignActive:(LBModuleContext *)context;

- (void)modDidEnterBackground:(LBModuleContext *)context;

- (void)modWillEnterForeground:(LBModuleContext *)context;

- (void)modDidBecomeActive:(LBModuleContext *)context;

- (void)modWillTerminate:(LBModuleContext *)context;

- (void)modUnmount:(LBModuleContext *)context;

- (void)modOpenURL:(LBModuleContext *)context;

- (void)modDidReceiveMemoryWaring:(LBModuleContext *)context;

- (void)modDidFailToRegisterForRemoteNotifications:(LBModuleContext *)context;

- (void)modDidRegisterForRemoteNotifications:(LBModuleContext *)context;

- (void)modDidReceiveRemoteNotification:(LBModuleContext *)context;

- (void)modDidReceiveLocalNotification:(LBModuleContext *)context;

- (void)modWillPresentNotification:(LBModuleContext *)context;

- (void)modDidReceiveNotificationResponse:(LBModuleContext *)context;

- (void)modWillContinueUserActivity:(LBModuleContext *)context;

- (void)modContinueUserActivity:(LBModuleContext *)context;

- (void)modDidFailToContinueUserActivity:(LBModuleContext *)context;

- (void)modDidUpdateContinueUserActivity:(LBModuleContext *)context;

- (void)modHandleWatchKitExtensionRequest:(LBModuleContext *)context;

- (void)modDidCustomEvent:(LBModuleContext *)context;

// 管理模块下的服务

// 记录模块下服务的调用次数、创建次数(单例1次 非单例多次与调用次数相同)、服务与实例的映射、服务异常、终止服务

@end
