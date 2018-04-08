//
//  LBModuleContext.m
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "LBModuleContext.h"

@interface LBModuleContext()

@property(nonatomic, strong) NSMutableDictionary *modulesByName;

@property(nonatomic, strong) NSMutableDictionary *servicesByName;

@end

@implementation LBModuleContext

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id BHInstance = nil;
    
    dispatch_once(&p, ^{
        BHInstance = [[[self class] alloc] init];
        if ([BHInstance isKindOfClass:[LBModuleContext class]]) {
//            ((BHContext *) BHInstance).config = [BHConfig shareInstance];
        }
    });
    
    return BHInstance;
}

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName
{
    [[LBModuleContext shareInstance].servicesByName setObject:implInstance forKey:serviceName];
}

- (void)removeServiceWithServiceName:(NSString *)serviceName
{
    [[LBModuleContext shareInstance].servicesByName removeObjectForKey:serviceName];
}

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName
{
    return [[LBModuleContext shareInstance].servicesByName objectForKey:serviceName];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.modulesByName  = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.servicesByName  = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.moduleConfigName = @"BeeHive.bundle/BeeHive";
        self.serviceConfigName = @"BeeHive.bundle/BHService";
    }
    
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    LBModuleContext *context = [[self.class allocWithZone:zone] init];
    
    context.env = self.env;
    context.appkey = self.appkey;
    context.customEvent = self.customEvent;
    context.application = self.application;
    context.launchOptions = self.launchOptions;
    context.moduleConfigName = self.moduleConfigName;
    context.serviceConfigName = self.serviceConfigName;
    context.customParam = self.customParam;
    
    return context;
}

@end
