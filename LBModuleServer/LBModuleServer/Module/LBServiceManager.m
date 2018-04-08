//
//  LBServiceManager.m
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/4.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "LBServiceManager.h"
#import "LBModuleContext.h"
//#import "BHAnnotation.h"
#import <objc/runtime.h>

static const NSString *kService = @"service";
static const NSString *kImpl = @"impl";

@interface LBServiceManager()

@property (nonatomic, strong) NSMutableDictionary *allServicesDict;
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation LBServiceManager
+ (instancetype)sharedManager
{
    static id sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)registerLocalServices
{
    NSString *serviceConfigName = [LBModuleContext shareInstance].serviceConfigName;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:serviceConfigName ofType:@"plist"];
    if (!plistPath)
    {
        return;
    }
    
    NSArray *serviceList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [self.lock lock];
    for (NSDictionary *dict in serviceList) {
        NSString *protocolKey = [dict objectForKey:@"service"];
        NSString *protocolImplClass = [dict objectForKey:@"impl"];
        if (protocolKey.length > 0 && protocolImplClass.length > 0)
        {
            [self.allServicesDict addEntriesFromDictionary:@{protocolKey:protocolImplClass}];
        }
    }
    [self.lock unlock];
}

- (void)registerService:(Protocol *)service implClass:(Class)implClass
{
    NSParameterAssert(service != nil);
    NSParameterAssert(implClass != nil);
    
    if (![implClass conformsToProtocol:service])
    {
        if (self.enableException)
        {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(implClass), NSStringFromProtocol(service)] userInfo:nil];
        }
        return;
    }
    
    if ([self checkValidService:service])
    {
        if (self.enableException)
        {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ protocol has been registed", NSStringFromProtocol(service)] userInfo:nil];
        }
        return;
    }
    
    NSString *key = NSStringFromProtocol(service);
    NSString *value = NSStringFromClass(implClass);
    
    if (key.length > 0 && value.length > 0)
    {
        [self.lock lock];
        [self.allServicesDict addEntriesFromDictionary:@{key:value}];
        [self.lock unlock];
    }
    
}

- (id)createService:(Protocol *)service
{
    id implInstance = nil;
    
    if (![self checkValidService:service])
    {
        if (self.enableException)
        {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ protocol does not been registed", NSStringFromProtocol(service)] userInfo:nil];
        }
        
    }
    
    // 是否单例服务对象在上下文环境中获取
    NSString *serviceStr = NSStringFromProtocol(service);
    id protocolImpl = [[LBModuleContext shareInstance] getServiceInstanceFromServiceName:serviceStr];
    if (protocolImpl)
    {
        return protocolImpl;
    }
    
    // 获取服务的类
    Class implClass = [self serviceImplClass:service];
    // 单例对象
    if ([[implClass class] respondsToSelector:@selector(singleton)]) {
        if ([[implClass class] singleton]) {
            if ([[implClass class] respondsToSelector:@selector(shareInstance)])
            {
                implInstance = [[implClass class] shareInstance];
            }
            else
            {
                implInstance = [[implClass alloc] init];
            }
            // 单例类加入到上下文
            [[LBModuleContext shareInstance] addServiceWithImplInstance:implInstance serviceName:serviceStr];
            return implInstance;
        }
    }
    
    // 返回服务实例对象
    return [[implClass alloc] init];
}

- (Class)createServiceClass:(Protocol *)service {
    
    // 获取服务的类
    Class implClass = [self serviceImplClass:service];
    
    return implClass;
}

#pragma mark - private
- (Class)serviceImplClass:(Protocol *)service
{
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0)
    {
        return NSClassFromString(serviceImpl);
    }
    return nil;
}

- (BOOL)checkValidService:(Protocol *)service
{
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0)
    {
        return YES;
    }
    return NO;
}

- (NSMutableDictionary *)allServicesDict
{
    if (!_allServicesDict)
    {
        _allServicesDict = [NSMutableDictionary dictionary];
    }
    return _allServicesDict;
}

- (NSRecursiveLock *)lock
{
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

- (NSDictionary *)servicesDict
{
    [self.lock lock];
    NSDictionary *dict = [self.allServicesDict copy];
    [self.lock unlock];
    return dict;
}

@end
