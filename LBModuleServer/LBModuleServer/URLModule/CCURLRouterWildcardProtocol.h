//
//  CCURLRouterWildcardProtocol.h
//  LBModuleServer
//
//  Created by 李冰 on 2019/1/18.
//  Copyright © 2019 李冰. All rights reserved.
//

/**
 * Provide user custom wildcard protocol
 * Suggest user like $[user_token]
 */

@protocol CCURLRouterWildcardProtocol <NSObject>

@optional

/**
 Custom wildcard array.
 Example:
 
 - (NSArray *)wildcards {
 return @[
 @"$[user_token]",
 @"$[user_name]"
 ]
 @end

 @return A wildcard array.
 */
- (NSArray *)wildcards;

/**
 Value for wildcard
 
 @param wildcard wildcard

 @return Value will replace widcard
 */
- (NSString *)valueForWildcard:(NSString *)wildcard;

/**
 When value for wildcard is null, callback this method.

 @param wildcard wildcard
 */
- (void)nullValueForWildcard:(NSString *)wildcard;

@end
