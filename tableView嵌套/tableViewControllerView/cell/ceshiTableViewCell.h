//
//  ceshiTableViewCell.h
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSPageContentView.h"

@interface ceshiTableViewCell : UITableViewCell


@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
