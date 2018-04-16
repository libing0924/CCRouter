//
//  CCURLSchedule.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCURLSchedule : NSObject

+ (id)shareInstance;

- (BOOL)rigisterURL:(NSURL *)URL calss:(Class)className;
- (BOOL)unregisterURL:(NSURL *)URL calss:(Class)className;
- (Class)classWithURL:(NSURL *)URL;

- (BOOL)openURL:(NSURL *)URL;
- (BOOL)openURL:(NSURL *)URL customParameter:(NSDictionary *)parameter;
- (BOOL)openURL:(NSURL *)URL openMethod:(NSString *)openMethod authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter;
- (id)objectFromURL:(NSURL *)URL;
- (Class)classFromURL:(NSURL *)URL;

@end
