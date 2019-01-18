//
//  CCViewController+URLRouter.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/19.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "UIViewController+URLRouter.h"
#import "CCURLSchedule.h"

NSString * const CCURLRouterOpenMethodKey = @"openMethod";

NSString * const CCURLRouterOpenMethodPush = @"openMethodPush";
NSString * const CCURLRouterOpenMethodPresent = @"openMethodPresent";

@implementation UIViewController (URLRouter)

- (void)openURL:(NSString *)URLStr openMethod:(NSString *)openMethod {
    
    id object = [[CCURLSchedule shareInstance] objectFromURL:URLStr customParameter:nil];
    
    if (openMethod == CCURLRouterOpenMethodPush)
    {
        if (self.navigationController)
        {
            [self.navigationController pushViewController:object animated:YES];
        }
    }
    else if (openMethod == CCURLRouterOpenMethodPresent)
    {
        [self presentViewController:object animated:YES completion:nil];
    }
    else
    {
        [self presentViewController:object animated:YES completion:nil];
    }
}

@end
