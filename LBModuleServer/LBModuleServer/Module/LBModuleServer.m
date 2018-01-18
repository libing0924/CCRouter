//
//  LBManagerUnit.m
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/4.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "LBModuleServer.h"

@implementation LBModuleServer

#pragma mark - public

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id BHInstance = nil;
    
    dispatch_once(&p, ^{
        BHInstance = [[self alloc] init];
    });
    
    return BHInstance;
}

// 消息转发
+ (void)registerDynamicModule:(Class)moduleClass
{
    [[LBModuleManager sharedManager] registerDynamicModule:moduleClass];
}
// 消息转发
+ (void)triggerCustomEvent:(NSInteger)eventType
{
    if(eventType < 1000) {
        return;
    }
    
    [[LBModuleManager sharedManager] triggerEvent:eventType];
}

// 消息转发
- (id)createService:(Protocol *)proto;
{
    return [[LBServiceManager sharedManager] createService:proto];
}

// 消息转发
//char * kShopModule_mod __attribute((used, section("__DATA,""BeehiveMods"" "))) = """ShopModule""";
- (void)registerService:(Protocol *)proto service:(Class) serviceClass
{
    [[LBServiceManager sharedManager] registerService:proto implClass:serviceClass];
}

#pragma mark - Private

-(void)setContext:(LBModuleContext *)context
{
    _context = context;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadStaticServices];
        [self loadStaticModules];
    });
}

// 加载静态模块
- (void)loadStaticModules
{
    
    [[LBModuleManager sharedManager] loadLocalModules];
    
    [[LBModuleManager sharedManager] registedAllModules];
    
}
// 加载静态服务
-(void)loadStaticServices
{
    [LBServiceManager sharedManager].enableException = self.enableException;
    
    [[LBServiceManager sharedManager] registerLocalServices];
    
}

@end
