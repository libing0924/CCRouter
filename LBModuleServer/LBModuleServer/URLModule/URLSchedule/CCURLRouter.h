//
//  CCURLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCURLRouter : NSObject

- (id)openURL:(NSURL *)URL fromObject:(id)fromObject;

- (id)openURL:(NSURL *)URL fromObject:(id)fromObject block:(void(^)(NSDictionary *parameter))block;

@end
