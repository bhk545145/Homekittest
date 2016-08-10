//
//  RoomViewTableViewController.m
//  Homekittest
//
//  Created by 白洪坤 on 16/8/10.
//  Copyright © 2016年 白洪坤. All rights reserved.
//

#import "RoomViewTableViewController.h"
#import "AccessorieViewTableViewController.h"

@interface RoomViewTableViewController ()

@end

@implementation RoomViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setHome:(HMHome *)home{
    _home = home;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_home.rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimleTableIdentifier = @"SimleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimleTableIdentifier];
    }
    HMRoom *room = _home.rooms[indexPath.row];
    cell.textLabel.text = room.name;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"accessorieView" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"accessorieView"]) {
        UIViewController *target = segue.destinationViewController;
        if ([target isKindOfClass:[AccessorieViewTableViewController class]]) {
            AccessorieViewTableViewController* deviceVC = (AccessorieViewTableViewController *)target;
            NSIndexPath *indexPath = (NSIndexPath*)sender;
            deviceVC.room = _home.rooms[indexPath.row];
        }
    }
}


@end
