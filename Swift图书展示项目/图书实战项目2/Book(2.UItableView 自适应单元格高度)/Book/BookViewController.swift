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
    let URLString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    var books = [Book]()
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetManager.GET(URLString, parameters: ["tag" : tag,"start":0,"count":10], success: { (responseObject) in
//            print(responseObject)
            self.books = [] //block 中必须写 self 提醒你可能会循环引用
            if let dict = responseObject as? [String:NSObject],array = dict[self.KeyBooks] as? [[String:NSObject]]{
                for dict in array{
                    self.books.append(Book(dict: dict))
                }
                self.tableView.reloadData()
            }
            
            }) { (error) in
                print(error)
        }
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

}

