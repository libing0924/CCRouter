//
//  CCURLSchedule.h
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCURLProtocol.h"


@interface CCURLSchedule : NSObject

+ (id)shareInstance;

- (BOOL)registerLocalURLWithPath:(NSString *)path;
- (BOOL)registerURL:(NSString *)URLStr calss:(Class)className;
- (BOOL)registerURL:(NSString *)URL calssName:(Class)className queryDescription:(NSString *)queryDescription;
- (BOOL)unregisterURL:(NSString *)URLStr calss:(Class)className;


- (BOOL)openURL:(NSString *)URLStr;
- (BOOL)openURL:(NSString *)URLStr customParameter:(NSDictionary *)parameter;
- (BOOL)openURL:(NSString *)URLStr openMethod:(NSString *)openMethod authorization:(NSString *)authorization ID:(NSString *)ID customParameter:(NSDictionary *)parameter;
- (Class)classFromURL:(NSString *)URLStr;

@end
