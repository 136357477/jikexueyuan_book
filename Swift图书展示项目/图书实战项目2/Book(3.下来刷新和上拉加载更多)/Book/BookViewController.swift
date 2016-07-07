//
//  BookViewController.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class BookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - Property -
    let identifierBookCell = "BookCell"
    let KeyBooks = "books"
    var page = 0 //当前刷新的第几页
    let pageSize = 10
    let URLString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    var books = [Book]()
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addMJHeaderAndFooter()
        tableView.headerBeginRefresh()
      // iOS 之后tableview 引入的动态计算行高
        tableView.estimatedRowHeight = 100 //tableview 的预计行高改为100
        tableView.rowHeight = UITableViewAutomaticDimension // 动态 计算行高
    }
    
    //MARK - UITableView -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier(identifierBookCell, forIndexPath: indexPath) as! BookCell
        bookCell.configureWithBook(books[indexPath.row])
        return bookCell
    }
    //MARK: - MJRefresh -
    //定义一个私有方法  添加上拉和下拉控件 和上拉下拉后的操作
    private func addMJHeaderAndFooter(){
        tableView.headerAddMJREfresh { //这里面是一个 block
            //TODO: (很重要) 移除底部没有数据状态
            self.tableView.footerResetNoMoreData()
            //block 里面变量需要加 self
            NetManager.GET(self.URLString, parameters: ["tag" : self.tag,"start":0,"count":self.pageSize],showHUD: false, success: { (responseObject) in
                //            print(responseObject)
                self.books = [] //block 中必须写 self 提醒你可能会循环引用
                if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                    for dict in array{
                        self.books.append(Book(dict: dict))
                    }
                    self.page = 1
                    
                        self.tableView.reloadData()
                    
                    
                }
                
                self.tableView.headerEndRefresh()
            }) { (error) in
                print(error)
                self.tableView.headerEndRefresh()
            }
        }
        
        
        tableView.footerAddMJRefresh { //这里面是一个 block
            //block 里面变量需要加 self
            NetManager.GET(self.URLString, parameters: ["tag" : self.tag,"start":self.page * self.pageSize,"count":self.pageSize],showHUD: false, success: { (responseObject) in
                var indexPaths = [NSIndexPath]()
                if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                    let count = self.books.count
                    for (i,dict) in array.enumerate(){ //添加一个带索引的遍历
                        self.books.append(Book(dict: dict))
                        indexPaths.append(NSIndexPath(forRow: count + i ,inSection: 0))
                    }
                }
                if indexPaths.isEmpty{
                    
                        self.tableView.footerEndRefreshNoMoreData()
                    
                }else{
                    self.page += 1
                    
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic) //动画
                    
                }
            }) { (error) in
                print(error)
                
                    self.tableView.headerEndRefresh()
                
            }
        }

        
    }
    
    
}

