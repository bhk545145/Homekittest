//
//  ViewController.h
//  Homekittest
//
//  Created by 白洪坤 on 16/8/9.
//  Copyright © 2016年 白洪坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *homeNamefild;
- (IBAction)addhomebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

