//
//  CCURLPool.m
//  LBModuleServer
//
//  Created by 李冰 on 2018/4/16.
//  Copyright © 2018年 李冰. All rights reserved.
//

#import "CCURLPool.h"

@interface CCURLPool ()

@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation CCURLPool

+ (id)shareInstance {
    
    static CCURLPool *pool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        pool = [[CCURLPool alloc] init];
    });
    
    return pool;
}

- (void)loadLocalURLPoolWithPath:(NSString *)path {
    
}

- (void)setURLPoolCapacity:(NSInteger)capacity {
    
}

- (Class)classNameForURL:(NSString *)URL {
    
    if (!URL) return nil;
    
    NSString *className = [self.dataSource objectForKey:URL];
    
    Class class = NSClassFromString(className);
    
    return class;
}

- (void)addClass:(Class)className URL:(NSString *)URL {
    
    if (!className || !URL) return;
    
    [self.dataSource setObject:NSStringFromClass(className) forKey:URL];
}

- (void)removeClassFromURL:(NSString *)URL {
    
    [self.dataSource removeObjectForKey:URL];
}

@end
