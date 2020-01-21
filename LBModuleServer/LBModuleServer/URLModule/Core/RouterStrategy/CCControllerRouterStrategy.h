//
//  CCControllerRouterStrategy.h
//  LBModuleServer
//
//  Created by 李冰 on 2016/1/10.
//  Copyright © 2016 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCRouter;

@protocol CCRouterControllerProtocol <NSObject>

@optional
+ (UIViewController *)routerControllerWillBeInitiatedRoute:(NSString *)route parameters:(NSDictionary *)parameters;

- (BOOL)routerControllerWillBeOpenedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters;

- (UINavigationController *)navigationControllerWhenPresentedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters;

@end

@protocol CCRouterRouteStrategy <NSObject>

@required

/// Return rewritten and pure route
/// @param route Original route
- (NSString *)routeWithOriginalRoute:(NSString *)route;

/// Return independent parameters from route
/// @param route Route
- (NSDictionary *)parametersWithRoute:(NSString *)route;

@end

@protocol CCRouterGenerationStrategy <NSObject>

@required

/// Generate and return destination instance with class
/// @param cls Class
/// @param route Route
/// @param parameters Parameters
- (id)generateDestinationWithClass:(Class)cls route:(NSString *)route parameters:(NSDictionary *)parameters;

@optional

/// Generate new origination instance
/// @param originalOrigination Original origination instance
/// @param route Route
- (id)generateOriginationWithOriginalOrigination:(id)originalOrigination route:(NSString *)route;

@end


typedef NS_ENUM(NSInteger, CCRouterControllerOpenType) {
    
    CCRouterControllerOpenTypeAuto = 0,
    CCRouterControllerOpenTypePush = 1,
    CCRouterControllerOpenTypeModal = 2,
};

@protocol CCRouterOpenStrategy <NSObject>

@property (nonatomic, assign) BOOL pushAnimation;
@property (nonatomic, assign) BOOL modalAnimation;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, assign) CCRouterControllerOpenType openType;

@required

/// Handle open logical
/// @param destination Destination instance
/// @param origination Origination instance
/// @param route Route
/// @param parameters parameters
- (void)openDestination:(id)destination origination:(id)origination route:(NSString *)route parameters:(NSDictionary *)parameters;

@end
