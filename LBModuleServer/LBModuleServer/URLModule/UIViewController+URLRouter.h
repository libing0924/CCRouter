//
//  CCViewController+URLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/19.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const CCURLRouterOpenMethodKey;
UIKIT_EXTERN NSString * const CCURLRouterOpenMethodPush;
UIKIT_EXTERN NSString * const CCURLRouterOpenMethodPresent;

@interface UIViewController (URLRouter)

- (void)openURL:(NSString *)URLStr openMethod:(NSString *)openMethod;

@end
