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

- (BOOL)registerURL:(NSURL *)URL calssName:(NSString *)className queryDes:(NSDictionary<NSString *, NSString *> *)des;

- (BOOL)registerURL:(NSURL *)URL object:(id)object selector:(NSString *)selector queryDes:(NSDictionary<NSString *, NSString *> *)des;

@end
