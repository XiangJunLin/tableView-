//
//  BaseTabeView.h
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import <UIKit/UIKit.h>


/**********************************************
 为了防止tableview 嵌套 tableview 时 手势冲突的问题
 首先必须要 实现UIGestureRecognizerDelegate这个手势的代理
 **********************************************/

@interface BaseTabeView : UITableView<UIGestureRecognizerDelegate>

@end
