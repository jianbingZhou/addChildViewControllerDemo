//
//  ThreeTableViewController.m
//  AddChildViewControllerDemo
//
//  Created by Terra MacBook on 16/9/13.
//  Copyright © 2016年 JianbingZhou. All rights reserved.
//

#import "ThreeTableViewController.h"

@interface ThreeTableViewController ()

@end

@implementation ThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     NSLog(@"viewDidLoad--Three");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear--Three");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
