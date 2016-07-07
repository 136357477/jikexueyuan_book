//
//  DetailViewController.swift
//  Book
//
//  Created by guohui on 16/6/28.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var book:Book! //定义一个 book 类型的对象
    var page  = 0
    var reviews  = [Review]() // 评论数组
    
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailHeadView.showInTableView(tableView, book: book)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension // 行高自动估算
        tableView.tableFooterView = UIView()
    }
    /**
     请求图书数据
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
         tableView.footerAddMJRefresh { 
            NetManager.getReviewsWithBookId(self.book.id, page:  self.page, resultClousure: { (result, reviews) in
                if result {
                    //如果请求成功
                    let count = self.reviews.count
                    var indexPaths = [NSIndexPath]() //NSIndexPath 数组用于遍历数据
                    for (i,review) in reviews.enumerate(){
                        self.reviews.append(review)
                        indexPaths.append(NSIndexPath(forRow: count + i , inSection: 0))
                    }
                    if indexPaths.isEmpty {
                        self.tableView.footerResetNoMoreData() // 没有更多数据
                    }else{
                        self.page+=1
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.tableView.footerEndRefresh()
                    }
                    
                }else{
                    self.view.makeToast("网络异常,请上拉重试")
                    self.tableView.footerEndRefresh()
                }
            })
        }
        tableView.footerBeginRefresh()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewCell", forIndexPath: indexPath) as! ReviewCell
        cell.configureWithReview(reviews[indexPath.row])
        return cell
    }
    //返回
    @IBAction func back(sender: AnyObject) {
         navigationController?.popViewControllerAnimated(true) // 退出控制器
    }




}
