//
//  ModelViewController.m
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import "ModelViewController.h"


@interface ModelViewController ()



@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma -mark -----------------------------tableview datasource and delegate---------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"JDGoodsViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titleStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.00001f;
}

//这里是主要的控制中心.
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!self.vcCanScroll == YES){
        
        scrollView.contentOffset = CGPointZero;
    }
    
    //如今这个判断成了表示 子试图回到最顶上了
    if(scrollView.contentOffset.y <=0){
        
        self. self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        //到顶后通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop2" object:nil];
    }
    
    //和父试图的道理是一样的
    self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
