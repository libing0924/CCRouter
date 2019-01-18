//
//  CCViewController+URLRouter.h
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/19.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const CCURLRouterOpenMethodKey;
FOUNDATION_EXTERN NSString * const CCURLRouterOpenMethodPush;
FOUNDATION_EXTERN NSString * const CCURLRouterOpenMethodPresent;

@interface UIViewController (URLRouter)

- (void)openURL:(NSString *)URLStr openMethod:(NSString *)openMethod;

@end
