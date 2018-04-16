//
//  CCURLRegister.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

// 由于OC没有包的概念URL建议格式：scheme://productName.moduleName/subModuleName/../className?key=value

#import <Foundation/Foundation.h>

@interface CCURLRegister : NSObject

//{url:@"";className:@"";parameterDes:@""}
- (BOOL)registerLocalWithPath:(NSString *)path;

- (BOOL)rigisterURL:(NSURL *)URL calss:(Class)className;

// 建议开发人员采用此方法对自己所写模块的入参进行说明
- (BOOL)rigisterURL:(NSURL *)URL calss:(Class)className parameterDescription:(NSString *)parameterDes;

- (BOOL)unregisterURL:(NSURL *)URL calss:(Class)className;

//- (BOOL)registerURL:(NSURL *)URL object:(id)object;
//
//- (BOOL)unregisterURL:(NSURL *)URL object:(id)object;

- (Class)classWithURL:(NSURL *)URL;

@end
