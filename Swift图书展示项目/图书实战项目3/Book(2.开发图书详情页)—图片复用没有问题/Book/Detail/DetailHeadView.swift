//
//  DetailHeadView.swift
//  Book
//
//  Created by guohui on 16/6/28.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class DetailHeadView: UIView {
    //MARK: - Property -
    var tableView:UITableView!
    var book:Book!
    
    
    
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var ratingViewContainer: UIView!
    @IBOutlet weak var labelRateNum: UILabel!
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var labelSummary: UILabel!

    //添加一个接口
    static func showInTableView(tableView:UITableView,book:Book) -> DetailHeadView{
        let headView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! DetailHeadView
        headView.configureWith(tableView, book: book)
        return headView
    }
    //对象方法
    func configureWith(tableView:UITableView,book:Book) {
        self.tableView = tableView
        self.book = book
        imageViewIcon.sd_setImageWithURL(NSURL(string: book.image))
        
        labelName.text = book.title
        if let rating = book.rating {
            RatingView.showInView(ratingViewContainer, value: rating.averager)
            labelRateNum.text = "\(rating.numRaters)人评分"
        }else{
            //没有评分
            RatingView.showNoRating(ratingViewContainer)
        }
        
        var desc = ""
        for str in book.author {
            desc += (str + "/")
        }
        
        labelPublisher.text = desc + book.publisher + "/" + book.pubdate
        labelSummary.text = book.summary
        self.tableView.tableHeaderView = self //tableView.tableHeaderView 置成我们自定义的tableHeaderView 
    }
    
    /**
     解决简介文字显示不全
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = viewContainer.frame.size.height + 8
        tableView.tableHeaderView = self
    }
    
    //评论
    @IBAction func comment(sender: AnyObject) {
        
    }
    //收藏
    @IBAction func collect(sender: AnyObject) {
        
    }

    

}
