//
//  cheshiViewController.m
//  tableView嵌套
//
//  Created by 向俊霖 on 2018/8/21.
//  Copyright © 2018年 向俊霖. All rights reserved.
//

#import "cheshiViewController.h"
#import "ModelViewController.h"
#import "ceshiTableViewCell.h"
#import "BaseTabeView.h"
#import "LiuXSegmentView.h"

@interface cheshiViewController ()<FSPageContentViewDelegate,UIScrollViewDelegate,FSPageContentViewDelegate>
@property (weak, nonatomic) IBOutlet BaseTabeView *tableview;

/** 标题的数组 */
@property(strong, nonatomic) NSArray *titleArr;
/** 把这个定义为全局 */
@property(strong, nonatomic) ceshiTableViewCell *ceshicell;
/** 是否可以滑动 */
@property (nonatomic, assign) BOOL canScroll;
/**类型栏*/
@property (nonatomic, weak) LiuXSegmentView *Liuview;

@end

@implementation cheshiViewController

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

- (NSArray *)titleArr{
    
    if(!_titleArr){
        
        _titleArr = @[@"生活",@"科学",@"自然"];
    }
    
    return _titleArr;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜艺";
    self.canScroll = YES;
    //重子视图中穿出来的通知 告诉 父控制器中的tableviwe 可以进行滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop2" object:nil];
    
}

- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.ceshicell.cellCanScroll = NO;
}

#pragma -mark -----------------------------tableview datasource and delegate---------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 10;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 60;
    }else{
        return 667;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 1){
        _ceshicell = [ceshiTableViewCell cellWithTableView:tableView];
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString *titleStr in self.titleArr) {

            ModelViewController *vc = [[ModelViewController alloc]init];
            vc.titleStr = titleStr;
            [contentVCs addObject:vc];

        }

        //这里在进行一次判断（防止数据为空）
        if(contentVCs.count == 0) return _ceshicell;
        _ceshicell.viewControllers = contentVCs;
        _ceshicell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) childVCs:contentVCs parentVC:self delegate:self];
        _ceshicell.pageContentView.backgroundColor = [UIColor whiteColor];
        [_ceshicell.contentView addSubview:_ceshicell.pageContentView];

        return _ceshicell;
    }
    
    static NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"哈哈啊哈哈哈啊哈哈哈";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if(section == 1){
        
        //这个section 没有使用到重用机制.
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        if(self.titleArr.count == 0){
            return view;
        }
        //这个框架我我修改过。（下划线 和文字 对起）
        __weak typeof(self) weakslf = self;
        LiuXSegmentView *Liuview=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, 375, 50) titles:self.titleArr clickBlick:^void(NSInteger index) {
            weakslf.ceshicell.pageContentView.contentViewCurrentIndex = index - 1;
            
        }];
        //以下属性可以根据需求修改
        Liuview.titleFont= [UIFont systemFontOfSize:17];
        self.Liuview = Liuview;
        [view addSubview:Liuview];
        return view;
        
    }else{
        
        static NSString *headerSectionID = @"cityHeaderSectionID";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
        if (headerView == nil)
        {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(5, 0, 200, 30);
            titleLabel.textColor = [UIColor purpleColor];
            titleLabel.tag = 100;
            titleLabel.text = [NSString stringWithFormat:@"%ld",(long)section];
            [headerView addSubview:titleLabel];
        }
        return headerView;
    }
}

#pragma mark- FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    //endIndex即将下一页的索引
    self.Liuview.selectedIndex = endIndex;
    self.tableview.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    //可以根据滑动的progress 设置在滑动时候 下划线的 动画（我这里没有设置）
    NSLog(@"滑动比例---->%f",progress);
    self.tableview.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

- (void)FSContentViewWillBeginDragging:(FSPageContentView *)contentView{
    NSLog(@"开始滑动");
}

#pragma -mark- UIScrollViewDelegate
//这个代理中方法别乱改动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //这里是计算第二的一个Section的偏移量，
    CGFloat bottomCellOffset = [_tableview rectForSection:1].origin.y;
    
    if(scrollView.contentOffset.y >= bottomCellOffset){
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        
        if(self.canScroll){
            self.canScroll = NO;
            self.ceshicell.cellCanScroll = YES;
        }
    }else{
        
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            
        }
    }
    //    因为这里是2个tableview 嵌套，所以就会有2个滑动栏，这里进行判断，如果当前的tableView，不能移动了，就隐藏当前tableView的滑动栏
    self.tableview.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

@end
