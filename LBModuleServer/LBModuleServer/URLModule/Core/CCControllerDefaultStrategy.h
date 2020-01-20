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

@interface CCControllerRouterOpener : NSObject <CCRouterOpenStrategy>


@end

@interface CCControllerRouterRoute : NSObject <CCRouterRouteStrategy>


@end

@interface CCControllerRouterGenerator : NSObject <CCRouterGenerationStrategy>


@end
