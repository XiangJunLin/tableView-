//
//  BaseTabeView.m
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import "BaseTabeView.h"

@implementation BaseTabeView

/**
 在tableView嵌套使用的时候识别手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{return YES;}

@end
