//
//  CCURLRegister.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

// URL建议格式：scheme://productName.moduleName/subModuleName/../className?key=value
// 注册的时候传入的查询语句会自动填充到queryDescription说明

#import <Foundation/Foundation.h>

#define CC_URLPOOL_CLASS_NAME_KEY @"cc.urlPool.className.key"

#define CC_URLPOOL_QUERY_DES_KEY @"cc.urlPool.queryDescription.key"

@interface CCURLRegister : NSObject

//{url:@"";className:@"";queryDescription:@""}
- (BOOL)registerLocalWithPath:(NSString *)path;

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className;

// 建议开发人员采用此方法对自己所写模块的入参进行说明
- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDescription:(NSString *)queryDescription;

// 取消注册
- (BOOL)unregisterURL:(NSURL *)URL calssName:(NSString *)className;

// 获取注册信息
- (NSDictionary *)dataFromURL:(NSString *)URLStr;

@end
