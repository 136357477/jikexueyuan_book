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
    let KeyBooks = "books"
    var page = 0 //当前页码
    let pageSize = 10
    let URLString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    var books = [Book]()
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addMjHeaderAndFooter()
        tableView.headerBeginRefresh()
        tableView.estimatedRowHeight = 100 //tabView预计行高改为100
        tableView.rowHeight = UITableViewAutomaticDimension //tab行高动态计算
        
        
        
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
            
            
//            NetManager.GET(self.URLString, parameters: ["tag":self.tag,"start":self.page,"count":self.pageSize],showHUD: false, success: { (responseObject) -> Void in
//                //            print(responseObject)
//                self.books = [] //self 是用来提醒注意可能会循环引用
//                if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
//                    for dict in array {
//                        self.books.append(Book(dict: dict)) //
//                    }
//                    //                print(self.books.count)
//                    self.page = 1
//                    self.tableView.reloadData()
//                }
//                self.tableView.headerEndRefresh()
//                
//                }) { (error ) -> Void in
//                    print(error)
//                    self.tableView.headerEndRefresh()
//            }
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
                        self.page++
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                    
                    
                    
                }else{
                    self.tableView.footerEndRefresh()
                    self.view.makeToast("请求数据失败");
                }
            })
            
//            NetManager.GET(self.URLString, parameters: ["tag":self.tag,"start":self.page * self.pageSize,"count":self.pageSize],showHUD: false, success: { (responseObject) -> Void in
//                var indexPaths = [NSIndexPath]()
//                if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
//                    let count = self.books.count
//                    for (i,dict) in array.enumerate() {
//                        self.books.append(Book(dict: dict)) //
//                        indexPaths.append(NSIndexPath(forRow: count + i, inSection: 0))
//                    }
//                }
//                if indexPaths.isEmpty {
//                    self.tableView.footerEndRefreshNoMoreData()
//                }else{
//                    self.page++
//                    self.tableView.footerEndRefresh()
//                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
//                }
//                
//                }) { (error ) -> Void in
//                    print(error)
//                    self.tableView.footerEndRefresh()
//            }
        }
        
    }
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

