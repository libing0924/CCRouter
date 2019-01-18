//
//  CCURLSchedule.m
//  LBModuleServer
//
//  Created by 李冰 on 2017/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLSchedule.h"
#import "CCURLRegister.h"
#import "CCURLRouter.h"

@interface CCURLSchedule ()

@property (nonatomic, strong) CCURLRegister *URLRegister;

@property (nonatomic, strong) CCURLRouter *URLRouter;

@end

@implementation CCURLSchedule

+ (id)shareInstance {
    
    static CCURLSchedule *schedule = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        schedule = [[CCURLSchedule alloc] init];
    });
    
    return schedule;
}

- (BOOL)registerLocalURLWithPath:(NSString *)path {
    
    return [self.URLRegister registerLocalWithPath:path];
}

- (BOOL)registerURL:(NSString *)URLStr calss:(Class)className {
    
    return [self registerURL:URLStr calssName:className queryDescription:nil];
}

- (BOOL)registerURL:(NSString *)URLStr calssName:(Class)className queryDescription:(NSString *)queryDescription {
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return NO;
    
    return [self.URLRegister registerURL:URL calssName:NSStringFromClass(className) queryDescription:queryDescription];
}

- (BOOL)unregisterURL:(NSString *)URLStr calss:(Class)className {
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return NO;
    
    return [self.URLRegister unregisterURL:URL calssName:NSStringFromClass(className)];
}


- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject {
    
    return [self openURL:URLStr fromObject:fromObject customParameter:nil];
}

- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject customParameter:(NSDictionary *)parameter {
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return nil;
    
    return [self.URLRouter openURL:URL fromObject:fromObject customParameter:parameter];
}

- (Class)classFromURL:(NSString *)URLStr {
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return nil;
    
    NSString *className = [self.URLRouter classNameWithURL:URL];
    return NSClassFromString(className);
}

#pragma mark - lazy load
- (CCURLRegister *)URLRegister {
    
    if (_URLRegister) return _URLRegister;
    
    _URLRegister = [[CCURLRegister alloc] init];
    
    return _URLRegister;
}

- (CCURLRouter *)URLRouter {
    
    if (_URLRouter) return _URLRouter;
    
    _URLRouter = [[CCURLRouter alloc] init];
    
    return _URLRouter;
}

#pragma mark - pravity method
- (NSURL *)_processURLWithString:(NSString *)string {
    
    NSString *percentCodeString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *URL = [NSURL URLWithString:percentCodeString];
    
    return URL;
}

@end
