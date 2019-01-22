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
    
    return NO;
}

- (BOOL)registerURL:(NSString *)urlStr calssName:(NSString *)className {
    
    return [self registerURL:urlStr calssName:className queryDes:nil];
}
- (BOOL)registerURL:(NSString *)urlStr calssName:(NSString *)className queryDes:(NSDictionary<NSString *, NSString *> *)des {
    
    NSURL *url = [self _processURLWithString:urlStr];
    if (!url) return NO;
    
    Class class = NSClassFromString(className);
    if (!class) return NO;
    
    return [self.URLRegister registerURL:url calssName:className queryDes:des];
}

- (BOOL)registerURL:(NSString *)urlStr object:(id)object selector:(NSString *)selector {
    
    return [self registerURL:urlStr object:object selector:selector queryDes:nil];
}
- (BOOL)registerURL:(NSString *)urlStr object:(id)object selector:(NSString *)selector queryDes:(NSDictionary<NSString *, NSString *> *)des {
    
    NSURL *url = [self _processURLWithString:urlStr];
    if (!url) return NO;
    
    if (!object || !selector) return NO;
    
    return [self.URLRegister registerURL:url object:object selector:selector queryDes:des];
}

- (id)openURL:(NSString *)urlStr fromObject:(id)fromObject {
    
    return [self openURL:urlStr fromObject:fromObject block:nil];
}
- (id)openURL:(NSString *)urlStr fromObject:(id)fromObject block:(void(^)(NSDictionary *parameter))block {
    
    // handle wilcard
    if (self.wildcardDelegate) {
        urlStr = [self _handleUrlWildcard:urlStr];
    }
    
    NSURL *URL = [self _processURLWithString:urlStr];
    
    if (!URL) return nil;
    
    return [self.URLRouter openURL:URL fromObject:fromObject block:block];
}

- (NSDictionary *)infoFromURL:(NSString *)urlStr {
    
    return [[CCURLPool shareInstance] infoFromURL:urlStr];
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
