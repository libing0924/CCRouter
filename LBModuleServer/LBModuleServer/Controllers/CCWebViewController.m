//
//  CCWebViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/21.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCWebViewController.h"
#import <WebKit/WebKit.h>

@interface CCWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) CALayer *progresslayer;

@end

@implementation CCWebViewController {
    
    NSString *_urlStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self.view addSubview:[self.view viewWithTag:2020]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self initWithProgressView];
}

- (BOOL)routerControllerWillBeOpenedFromController:(UIViewController *)originationController route:(NSString *)route parameters:(NSDictionary *)parameters {
    
    _urlStr = route;
    return YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"Web view %@", navigationAction.request.URL.absoluteString);
    decisionHandler(YES);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
 if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        self.progresslayer.opacity = 1;
        
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) return;
     
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)initWithProgressView {
    
    CGFloat Y = self.navigationController.navigationBar.translucent ? CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) : 0;
    UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, Y, CGRectGetWidth(self.view.frame), 3)];
    [self.view addSubview:progress];
    progress.tag = 2020;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}

@end
