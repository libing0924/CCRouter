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

- (BOOL)registerURLWithLocalPath:(NSString *)path {
    
    return [self.URLRegister registerURLWithLocalPath:path];
}

- (BOOL)registerURL:(NSString *)URLStr calss:(Class)className {
    
    return [self registerURL:URLStr calssName:className queryDescription:nil];
}

- (BOOL)registerURL:(NSString *)URLStr calssName:(Class)className queryDescription:(NSString *)queryDescription {
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return NO;
    
    return [self.URLRegister registerURL:URL calssName:NSStringFromClass(className) queryDescription:queryDescription];
}

- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject {
    
    return [self openURL:URLStr fromObject:fromObject block:nil];
}

- (id)openURL:(NSString *)URLStr fromObject:(id)fromObject block:(void(^)(NSDictionary *parameter))block {
    
    // handle wilcard
    if (self.wildcardDelegate) {
        URLStr = [self _handleUrlWildcard:URLStr];
    }
    
    NSURL *URL = [self _processURLWithString:URLStr];
    
    if (!URL) return nil;
    
    return [self.URLRouter openURL:URL fromObject:fromObject block:block];
}

- (NSDictionary *)infoFromURL:(NSString *)URLStr {
    
    return [[CCURLPool shareInstance] infoFromURL:URLStr];
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

- (NSString *)_handleUrlWildcard:(NSString *)url {

    NSArray *wildcards = [self.wildcardDelegate wildcards].copy;
    
    
    for (NSString *wildcard in wildcards) {
        
        if ([wildcards isKindOfClass:NSString.class]) {
            
            NSString *value = [self.wildcardDelegate valueForWildcard:wildcard];
            url = [url stringByReplacingOccurrencesOfString:wildcard withString:value];
        }
    }
    
    return url;
}

@end
