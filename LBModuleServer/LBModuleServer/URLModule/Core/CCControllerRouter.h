//
//  CCControllerRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/9.
//  Copyright © 2016 李冰. All rights reserved.
//

// 外链安全策略：1.接口白名单（客户端处理） 2.web重定向（前端处理）
// Route采用标准的URL格式
// 是否使用IOC?
// 不同的open逻辑依赖scheme？

#import <UIKit/UIKit.h>
#import "CCControllerDefaultStrategy.h"

@interface CCControllerRouter : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> * _Nonnull routeMap;

@property (nonatomic, strong) id<CCRouterOpenStrategy> _Nonnull openStrategy;
@property (nonatomic, strong) id<CCRouterRouteStrategy> _Nonnull routeStrategy;
@property (nonatomic, strong) id<CCRouterGenerationStrategy> _Nonnull generatorStrategy;

+ (instancetype _Nonnull)sharedInstance;

- (Class _Nullable)classWithRoute:(NSString * _Nonnull)routerString;

- (void)registerRoute:(NSString * _Nonnull)route className:(NSString * _Nonnull)className;

- (void)openRoute:(NSString * _Nonnull)route;

- (void)openRoute:(NSString * _Nonnull)route originationController:(UIViewController *_Nullable)originationController;

@end
