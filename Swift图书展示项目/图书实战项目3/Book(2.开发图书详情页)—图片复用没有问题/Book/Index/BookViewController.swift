//
//  BookViewController.swift
//  Book
//
//  Created by guohui on 16/2/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class BookViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    //MARK: - Property -
    let identifierBookCell = "BookCell"
    var page = 0 //当前页码
    var tag = "文学" //关键字
    var books = [Book]()
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    //MARK: - life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addMjHeaderAndFooter()
        tableView.headerBeginRefresh()
        tableView.estimatedRowHeight = 100 //tabView预计行高改为100
        tableView.rowHeight = UITableViewAutomaticDimension //tab行高动态计算
        
        //设置 searchBar
        let searchController = storyboard?.instantiateViewControllerWithIdentifier("BookSearchController") as! BookSearchController //确定一定能转成 searchViewController 所以我们用 as! 强转
        //添加 bookController 的引用
        searchController.bookController = self
        //把 bookSearch 中的 searchBar 添加到当前的 searchViewController 中
        searchView.addSubview(searchController.searchController.searchBar)
    }
    
    //MARK:- UITableView -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count ;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier(identifierBookCell, forIndexPath: indexPath) as! BookCell
        bookCell.configureWithBook(books[indexPath.row])
        return bookCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.book = books[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    //MARK: - MJRefresh -
    
    private func addMjHeaderAndFooter(){
    
        tableView.headerAddMJRefresh { () -> Void in
            self.tableView.footerResetNoMoreData()
            NetManager.getBooks(self.tag, page: 0, resultClosure: { (result, books) -> Void in
                self.tableView.headerEndRefresh()
                if result {
                    self.page = 1
                    self.books = books
                    self.tableView.reloadData()
                }else{
                    self.view.makeToast("请求数据失败")
                }
            })
            
            

        }
        
        tableView.footerAddMJRefresh{ () -> Void in
            NetManager.getBooks(self.tag, page: self.page, resultClosure: { (result, books) -> Void in
                if result{
                     var indexPaths = [NSIndexPath]()
                    let count = self.books.count
                    for (i,book) in books.enumerate() {
                        self.books.append(book) //
                        indexPaths.append(NSIndexPath(forRow: count + i, inSection: 0))
                    }
                    if indexPaths.isEmpty{
                        self.tableView.footerEndRefreshNoMoreData()
                    }else{
                        self.page += 1
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                    
                    
                    
                }else{
                    self.tableView.footerEndRefresh()
                    self.view.makeToast("请求数据失败");
                }
            })
            
        }
        
    }
    

}

