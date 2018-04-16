//
//  CCURLPool.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

// 管理URL池，包括对池的增/删操作、缓存、本地数据处理

#import <Foundation/Foundation.h>

@interface CCURLPool : NSObject

+ (id)shareInstance;

// 加载本地URL池
- (void)loadLocalURLPoolWithPath:(NSString *)path;

// 设置容量默认无上限
- (void)setURLPoolCapacity:(NSInteger)capacity;

// 获取class name
- (Class)classFromURL:(NSString *)URL;

//- (id)objectForURL:(NSURL *)URL;

- (void)addClass:(nonnull Class)className URL:(nonnull NSString *)URL;

- (void)removeClassFromURL:(nonnull NSString *)URL;

@end
