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
    
    NSArray *datas = @[@{@"title" : @"Open With Action", @"route" : @"ccrouter://rootTabBar?selectedIndex=1", @"origination" : @(1)},
                       @{@"title" : @"Open With Parameter", @"route" : @"ccrouter://homeSearch?keyWord=风衣", @"origination" : @(1)},
                       @{@"title" : @"Open With Push", @"route" : @"ccrouter://unknowController?R$OpenType=1", @"origination" : @(1)},
                       @{@"title" : @"Open Router Config", @"route" : @"ccrouter://routerConfig", @"origination" : @(1)},
                       @{@"title" : @"Open Web Controller", @"route" : @"http://www.baidu.com", @"origination" : @(1)},];
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
