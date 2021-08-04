//
//  ceshiTableViewCell.m
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import "ceshiTableViewCell.h"
#import "ModelViewController.h"


@implementation ceshiTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"JDGoodsViewCell";
    ceshiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[ceshiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self.backgroundColor = [UIColor whiteColor];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
}


#pragma mark Setter
- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
}

-(void)setCellCanScroll:(BOOL)cellCanScroll{
    
    _cellCanScroll = cellCanScroll;
    
    for(ModelViewController *VC in self.viewControllers){
        
        VC.vcCanScroll = cellCanScroll;
        
        if(!cellCanScroll){//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            
            VC.tableView.contentOffset = CGPointZero;
        }
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
