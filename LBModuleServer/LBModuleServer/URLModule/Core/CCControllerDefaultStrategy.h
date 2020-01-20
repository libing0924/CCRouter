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

typedef NSString * CCControllerOpenType NS_EXTENSIBLE_STRING_ENUM;
UIKIT_EXTERN CCControllerOpenType const CCControllerOpenTypePush;
UIKIT_EXTERN CCControllerOpenType const CCControllerOpenTypePresent;

// 1.在这里添加通配符、route修改等
@interface CCControllerRouterRoute : NSObject <CCRouterRouteStrategy>


@end

// 2.在这里构建/修改源对象、目标对象
@interface CCControllerRouterGenerator : NSObject <CCRouterGenerationStrategy>


@end

// 3.在这里处理open的逻辑
@interface CCControllerRouterOpener : NSObject <CCRouterOpenStrategy>


@end
