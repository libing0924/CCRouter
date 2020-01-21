//
//  CCHomeViewController.m
//  LBModuleServer
//
//  Created by 李冰 on 2020/1/20.
//  Copyright © 2020 李冰. All rights reserved.
//

#import "CCHomeViewController.h"

static NSString * const CCHomeCellIde = @"CCHomeCellIde";

@interface CCHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CCHomeViewController {
    
    NSArray *_datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *datas = @[
                       @{@"title" : @"Open Action", @"route" : @"ccrouter://rootTabBar?selectedIndex=1"},
                       @{@"title" : @"Push Controller", @"route" : @"ccrouter://unknowController?R$OpenType=1"},
                       @{@"title" : @"Present Controller", @"route" : @"ccrouter://homeSearch?keyWord=Basketball"},
                       @{@"title" : @"Present Controller 2", @"route" : @"ccrouter://unknowController?R$OpenType=2"},
                       @{@"title" : @"Push Config", @"route" : @"ccrouter://routerConfig?R$OpenType=1"},
                       @{@"title" : @"Open Config Auto", @"route" : @"ccrouter://routerConfig"},
                       @{@"title" : @"Open Web Auto", @"route" : @"http://www.baidu.com"},
                      ];
    _datas = datas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CCHomeCellIde];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CCHomeCellIde];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    NSDictionary *data = _datas[indexPath.item];
    cell.textLabel.text = data[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *data = _datas[indexPath.item];
    NSString *route = data[@"route"];
    [[CCControllerRouter sharedInstance] openRoute:route originationController:self.navigationController];
}

@end
