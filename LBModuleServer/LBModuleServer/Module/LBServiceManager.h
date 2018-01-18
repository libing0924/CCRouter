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

- (void)registerLocalServices;

- (void)registerService:(Protocol *)service implClass:(Class)implClass;

- (id)createService:(Protocol *)service;

- (Class)createServiceClass:(Protocol *)service;

@end
