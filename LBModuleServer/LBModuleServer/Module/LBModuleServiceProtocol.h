//
//  LBModuleServiceProtocol.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/8.
//  Copyright © 2018年 李冰. All rights reserved.
//

// 需要纳入模块管理的服务需实现该协议

#import <Foundation/Foundation.h>
#import "LBModuleProtocol.h"

@protocol LBModuleServiceProtocol <NSObject>

@required

/**
 返回服务所属模块的实例

 @return 服务所属模块的实例
 */
- (id <LBModuleProtocol>)affiliateModule;

@optional
// 需要处理的模块事件

@end
