//
//  ViewController.m
//  Homekittest
//
//  Created by 白洪坤 on 16/8/9.
//  Copyright © 2016年 白洪坤. All rights reserved.
//

#import "ViewController.h"
#import "RoomViewTableViewController.h"
@import HomeKit;

@interface ViewController ()<HMHomeManagerDelegate,HMHomeDelegate,HMAccessoryBrowserDelegate>
//家庭管理类
@property (nonatomic,strong) HMHomeManager *homeManager;
//配件管理类
@property (nonatomic,strong) HMAccessoryBrowser *accessoryBrowser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];   
    self.view.backgroundColor = [UIColor whiteColor];
    _homeManager = [[HMHomeManager alloc]init];
    _homeManager.delegate = self;
    NSLog(@"primaryHome:%@",_homeManager.primaryHome);
    NSLog(@"homes:%@",_homeManager.homes);
    
    _accessoryBrowser = [[HMAccessoryBrowser alloc]init];
    _accessoryBrowser.delegate = self;
    //搜寻配件
    [_accessoryBrowser startSearchingForNewAccessories];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - homeManager delegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager{
    NSLog(@"homeManagerDidUpdateHomes:%@",manager);
    NSLog(@"primaryHome:%@",_homeManager.primaryHome);
    NSLog(@"homes:%@",_homeManager.homes);
    [self.tableview reloadData];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager{
    NSLog(@"homeManagerDidUpdatePrimaryHome:%@",manager);
}

- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home{
    NSLog(@"homeManager:%@,didAddHome:%@",manager,home);
}

- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home{
    NSLog(@"homeManager:%@,didRemoveHome:%@",manager,home);
}

#pragma mark - HMAccessoryBrowser delegate
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory{
    NSLog(@"browser:%@,accessory:%@",browser,accessory);
}
- (IBAction)addhomebtn:(id)sender {
    //添加家庭
    [_homeManager addHomeWithName:self.homeNamefild.text completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
        NSLog(@"addHomeWithName:%@,%@",home,error);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_homeManager.homes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimleTableIdentifier = @"SimleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimleTableIdentifier];
    }
    HMHome *home = _homeManager.homes[indexPath.row];
    cell.textLabel.text = home.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",home.primary];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"roomView" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"roomView"]) {
        UIViewController *target = segue.destinationViewController;
        if ([target isKindOfClass:[RoomViewTableViewController class]]) {
            RoomViewTableViewController* deviceVC = (RoomViewTableViewController *)target;
            NSIndexPath *indexPath = (NSIndexPath*)sender;
            deviceVC.home = _homeManager.homes[indexPath.row];
        }
    }
}
@end
