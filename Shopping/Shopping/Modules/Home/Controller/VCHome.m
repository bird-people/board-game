//
//  VCHome.m
//  Shopping
//
//  Created by simple on 2018/6/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCHome.h"
#import "AdsWindow.h"
#import <SDCycleScrollView.h>
#import "CellHome.h"
#import "VCContent.h"

@interface VCHome ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *scrollImgs;
@end

@implementation VCHome

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    AdsWindow *win = [[AdsWindow alloc]init];
    //    [win updateData:@"http://www.baidu.com" withTime:3];
    //    [win show];
    _dataSource = [NSMutableArray array];
    _scrollImgs = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self loadData];
}

- (void)loadData{
    __weak typeof(self) weakself = self;
    [[NetManager shareInstance] requestPost:Url_List paramater:nil withSuccess:^(id resobject) {
        if(resobject){
            NSInteger code = [resobject jk_integerForKey:@"code"];
            if(code == 200){
                NSArray *list = [resobject jk_arrayForKey:@"list"];
                NSArray *top_bar = [resobject jk_arrayForKey:@"top_bar"];
                [weakself.dataSource addObjectsFromArray:list];
                for (NSDictionary *data in top_bar) {
                    [weakself.scrollImgs addObject:[NSString stringWithFormat:@"%@%@",Base_Url,[data jk_stringForKey:@"thumb_url"]]];
                }
                weakself.cycleScrollView.imageURLStringsGroup = weakself.scrollImgs;
                [weakself.table reloadData];
            }
        }
    } withFailure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellHome calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellHome *cell = (CellHome*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellHome alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell.ivImg pt_setImage:[NSString stringWithFormat:@"%@%@",Base_Url,[data jk_stringForKey:@"thumb"]]];
    cell.lbTitle.text = [data jk_stringForKey:@"title"];
    cell.lbContent.text = [data jk_stringForKey:@"author"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*RATIO_WIDHT320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UIView alloc]init];
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    VCContent *vc = [[VCContent alloc]init];
    vc.data = data;
    vc.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.cycleScrollView;
    }
    return _table;
}


- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 153*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}


@end
