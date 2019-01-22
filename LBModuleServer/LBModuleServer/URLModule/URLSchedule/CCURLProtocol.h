//
//  CCURLProtocol.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCURLProtocol <NSObject>

- (BOOL)willOpenWithURL:(NSURL *)URL fromObject:(id)fromObject parameter:(NSDictionary *)systemParameter;

- (BOOL)willInjectWithURL:(NSURL *)URL fromObject:(id)fromObject parameter:(NSDictionary *)systemParameter;

- (void)beenOpenedWithURL:(NSURL *)URL fromObject:(id)fromObject parameter:(NSDictionary *)systemParameter block:(void (^)(NSDictionary *))block;

@end
