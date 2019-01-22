//
//  CCViewController+URLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/19.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const CCURLRouterControllerOpenMethodKey;
UIKIT_EXTERN NSString * const CCURLRouterControllerOpenMethodPush;
UIKIT_EXTERN NSString * const CCURLRouterControllerOpenMethodPresent;

UIKIT_EXTERN NSString * const CCURLRouterControllerTitleKey;

@interface UIViewController (URLRouter)

- (void)openURL:(NSString *)urlStr openMethod:(NSString *)openMethod;

@end
