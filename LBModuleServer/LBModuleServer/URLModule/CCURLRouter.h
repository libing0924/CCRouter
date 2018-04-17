//
//  CCURLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCURLRouter : NSObject

- (id)openURL:(NSURL *)URL;

- (id)openURL:(NSURL *)URL customParameter:(NSDictionary *)parameter;

- (id)openURL:(NSURL *)URL openMethod:(NSString *)openMethod authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter;

- (NSString *)classNameWithURL:(NSURL *)URL;

@end
