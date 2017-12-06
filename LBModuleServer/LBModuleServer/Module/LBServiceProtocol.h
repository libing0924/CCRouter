//
//  LBServiceProtocol.h
//  LBModuleRouter
//
//  Created by 李冰 on 2017/12/6.
//  Copyright © 2017年 李冰. All rights reserved.
//

// 服务提供的基础协议

#import <Foundation/Foundation.h>
@protocol BHServiceProtocol <NSObject>

@optional

+ (BOOL)singleton;

+ (id)shareInstance;

@end
