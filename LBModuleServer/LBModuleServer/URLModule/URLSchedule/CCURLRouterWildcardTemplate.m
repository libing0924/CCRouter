//
//  CCURLRouterWildcardTemplate.m
//  LBModuleServer
//
//  Created by 李冰 on 2019/1/18.
//  Copyright © 2019 李冰. All rights reserved.
//

#import "CCURLRouterWildcardTemplate.h"

@implementation CCURLRouterWildcardTemplate

- (NSArray *)wildcards {
    
    return @[@"$[user_token]", @"$[user_name]"];
}

- (NSString *)valueForWildcard {
    
    NSAssert(NO, @"You must override this method");
    return nil;
}

- (void)nullValueForWildcard:(NSString *)wildcard {
    
    NSAssert(NO, @"You must override this method");
}

@end
