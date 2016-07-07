//
//  UITableView+MJRefresh.h
//  Book
//
//  Created by guohui on 16/6/15.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh/MJRefresh.h"
@interface UITableView (MJRefresh)
/**
 *  定义一些接口
 */

 //添加底部刷新功能
-(void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block;

//手动顶部刷新
-(void)headerBeginRefresh ;

//取消顶部刷新
-(void)headerEndRefresh ;

//添加底部刷新
-(void)footerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block ;

//手动底部刷新
-(void)footerBeginRefresh ;

//取消底部刷新
-(void)footerEndRefresh ;

//底部上拉没有数据提示的 View
-(void)footerEndRefreshNoMoreData ;


//重置无数据状态
-(void)footerResetNoMoreData ;



@end
