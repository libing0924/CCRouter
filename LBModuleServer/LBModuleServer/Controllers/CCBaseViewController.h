//
//  CCBaseViewController.h
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCControllerRouter.h"
#import "CCControllerRouterStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBaseViewController : UIViewController<CCRouterControllerProtocol>

@end

NS_ASSUME_NONNULL_END
