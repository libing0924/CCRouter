//
//  CCURLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const CCURLRouterOpenMethodPush;

FOUNDATION_EXTERN NSString * const CCURLRouterOpenMethodPresent;

@interface CCURLRouter : NSObject

- (BOOL)openURL:(NSString *)URL;

- (BOOL)openURL:(NSString *)URL customParameter:(NSDictionary *)parameter;

- (BOOL)openURL:(NSString *)URL openMethod:(NSString *)openMethod authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter;

- (id)objectFromURL:(NSString *)URL;

- (Class)classFromURL:(NSString *)URL;

@end
