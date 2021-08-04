//
//  ModelViewController.h
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import "ViewController.h"

@interface ModelViewController : ViewController


@property (nonatomic, assign) BOOL vcCanScroll;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *titleStr;


@end
