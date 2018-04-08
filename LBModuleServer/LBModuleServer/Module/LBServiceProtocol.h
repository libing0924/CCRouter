//
//  LBServiceProtocol.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//

// 服务提供的基础协议
// 服务可以自定义外部的初始化API

#import <Foundation/Foundation.h>
@protocol BHServiceProtocol <NSObject>

@optional

// 如果是服务是单例，请务必实现该方法
+ (BOOL)singleton;
+ (id)shareInstance;

@end
