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
    var page = 0 //当前刷新的第几页
    var tag = "Swift"
    var books = [Book]()
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addMJHeaderAndFooter()
        tableView.headerBeginRefresh()
      // iOS 之后tableview 引入的动态计算行高
        tableView.estimatedRowHeight = 100 //tableview 的预计行高改为100
        tableView.rowHeight = UITableViewAutomaticDimension // 动态 计算行高
        
        //设置 searchBar
        let searchController = storyboard?.instantiateViewControllerWithIdentifier("BookSearchController") as! BookSearchController //确定一定能转成 searchViewController 所以我们用 as! 强转
        //添加 bookController 的引用
        searchController.bookController = self
        
        //把 bookSearch 中的 searchBar 添加到当前的 searchViewController 中
        searchView.addSubview(searchController.searchController.searchBar)
        
        
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
            
            NetManager.getBooks(self.tag, page: 0, resultClosure: { (result, books) in
                self.tableView.headerEndRefresh()
                if result {
                    self.page = 1
                    self.books = books
                    self.tableView.reloadData()
                }else{
                    //makeToast 不阻塞页面的吐司提示
                    self.view.makeToast("请求数据失败")
                }
            })
        }
        
        
        tableView.footerAddMJRefresh { //这里面是一个 block
            //block 里面变量需要加 self
            NetManager.getBooks(self.tag, page: self.page, resultClosure: { (result, books) in
                if result {
                    var indexPaths = [NSIndexPath]()
                    let count = self.books.count
                    for (i,book) in books.enumerate(){ //添加一个带索引的遍历
                        self.books.append(book)
                        indexPaths.append(NSIndexPath(forRow: count + i ,inSection: 0))
                    }
                    if indexPaths.isEmpty{
                        self.tableView.footerEndRefreshNoMoreData() //停止底部刷新,显示没有更多数据的页面
                    }else{
                        self.page+=1
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                }else{
                    self.tableView.footerEndRefresh()
                    self.view.makeToast("请求数据失败")
                }
            })
        }
     
        
    }
    
    
}

