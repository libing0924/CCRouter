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

@interface CCURLRegister : NSObject

//{url:@"";className:@"";queryDescription:@""}
- (BOOL)registerLocalWithPath:(NSString *)path;

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className;

// 建议开发人员采用此方法对自己所写模块的入参进行说明
- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDescription:(NSString *)queryDescription;

- (BOOL)unregisterURL:(NSURL *)URL calssName:(NSString *)className;

@end
