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

typedef enum
{
    BHEnvironmentDev = 0,
    BHEnvironmentTest,
    BHEnvironmentStage,
    BHEnvironmentProd
}BHEnvironmentType;


@interface LBModuleContext : NSObject <NSCopying>

//global env
@property(nonatomic, assign) BHEnvironmentType env;

//application appkey
@property(nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property(nonatomic, assign) NSInteger customEvent;

@property(nonatomic, strong) UIApplication *application;

@property(nonatomic, strong) NSDictionary *launchOptions;

@property(nonatomic, strong) NSString *moduleConfigName;

@property(nonatomic, strong) NSString *serviceConfigName;

//3D-Touch model
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
//@property (nonatomic, strong) BHShortcutItem *touchShortcutItem;
//#endif
//
////OpenURL model
//@property (nonatomic, strong) BHOpenURLItem *openURLItem;
//
////Notifications Remote or Local
//@property (nonatomic, strong) BHNotificationsItem *notificationsItem;
//
////user Activity Model
//@property (nonatomic, strong) BHUserActivityItem *userActivityItem;
//
////watch Model
//@property (nonatomic, strong) BHWatchItem *watchItem;

//custom param
@property (nonatomic, copy) NSDictionary *customParam;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (void)removeServiceWithServiceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end
