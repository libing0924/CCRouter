//
//  CCURLProtocol.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCURLProtocol <NSObject>

- (BOOL)willBeOpenedWithURL:(NSURL *)URL fromObject:(id)fromObject systemParameter:(NSDictionary *)systemParameter customParameter:(NSDictionary *)parameter;

- (void)hasBeenOpenedWithURL:(NSURL *)URL fromObject:(id)fromObject systemParameter:(NSDictionary *)systemParameter customParameter:(NSDictionary *)parameter;

@end
