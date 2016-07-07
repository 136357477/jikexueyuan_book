//
//  UITableView+MJRefresh.m
//  Book
//
//  Created by guohui on 16/6/15.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import "UITableView+MJRefresh.h"

@implementation UITableView (MJRefresh)
//添加底部刷新功能
-(void)headerAddMJREfresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

//手动顶部刷新
-(void)headerBeginRefresh {
    [self.mj_header beginRefreshing];
}

//取消顶部刷新
-(void)headerEndRefresh {
    [self.mj_header endRefreshing];
}

//添加底部刷新
-(void)footerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
}

//手动底部刷新
-(void)footerBeginRefresh {
    [self.mj_footer beginRefreshing];
}

//取消底部刷新
-(void)footerEndRefresh {
    [self.mj_footer endRefreshing];
}

//底部上拉没有数据提示的 View
-(void)footerEndRefreshNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}


//重置无数据状态
-(void)footerResetNoMoreData {
    [self.mj_footer resetNoMoreData];
}


@end
