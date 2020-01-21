//
//  CCControllerDefaultStrategy.h
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/20.
//  Copyright © 2016 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCControllerRouterStrategy.h"

FOUNDATION_EXPORT NSString * const CCControllerOpenTypeQueryKey;
FOUNDATION_EXPORT NSString * const CCControllerModalStyleQueryKey;
FOUNDATION_EXPORT NSString * const CCControllerModalAnimationQueryKey; // Value is 0 or 1
FOUNDATION_EXPORT NSString * const CCControllerPushAnimationQueryKey; // Value is 0 or 1

// 1.在这里添加通配符、route修改等
@interface CCControllerRouterRoute : NSObject <CCRouterRouteStrategy>


@end

// 2.在这里构建/修改源对象、目标对象
@interface CCControllerRouterGenerator : NSObject <CCRouterGenerationStrategy>


@end

// 3.在这里处理open的逻辑
@interface CCControllerRouterOpener : NSObject <CCRouterOpenStrategy>

@property (nonatomic, assign) BOOL pushAnimation;
@property (nonatomic, assign) BOOL modalAnimation;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, assign) CCRouterControllerOpenType openType;

@end
