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

/// Can handle wildcard and redirect related logic
@interface CCControllerRouterRoute : NSObject <CCRouterRouteStrategy>


@end

/// Build/modify source and target objects
@interface CCControllerRouterGenerator : NSObject <CCRouterGenerationStrategy>


@end

// Handle open logical
@interface CCControllerRouterOpener : NSObject <CCRouterOpenStrategy>

@property (nonatomic, assign) BOOL pushAnimation;
@property (nonatomic, assign) BOOL modalAnimation;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, assign) CCRouterControllerOpenType openType;

@end
