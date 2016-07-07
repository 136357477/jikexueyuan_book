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
    
    weak var vc:DetailViewController!
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewRatingContainer: UIView!
    @IBOutlet weak var labelRateNum: UILabel!
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var labelSummary: UILabel!

    
    //添加一个接口
    static func showInTableView(vc:DetailViewController) -> DetailHeadView{
        let headView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! DetailHeadView
        headView.vc = vc
        headView.configureWith(vc.tableView, book: vc.book)
        headView.imageViewIcon.addGestureRecognizer(UITapGestureRecognizer(target: vc, action: "showImage"))
        return headView
    }
    

    //对象方法
    func configureWith(tableView:UITableView,book:Book) {
        imageViewIcon.sd_setImageWithURL(NSURL(string: book.images["large"] ?? ""))
        labelName.text = book.title
        if let rating = book.rating {
            RatingView.showInView(viewRatingContainer, value: rating.averager)
            labelRateNum.text = "\(rating.numRaters)人评分"
        }else{
            //没有评分
            RatingView.showNoRating(viewRatingContainer)
        }
        
        var desc = ""
        for str in book.author {
            desc += (str + "/")
        }
        
        labelPublisher.text = desc + book.publisher + "/" + book.pubdate
        labelSummary.text = book.summary
        vc.tableView.tableHeaderView = self //tableView.tableHeaderView 置成我们自定义的tableHeaderView
    }
    
    /**
     解决简介文字显示不全
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = viewContainer.frame.size.height + 8
        vc.tableView.tableHeaderView = self
    }
    
    //评论
    @IBAction func comment(sender: AnyObject) {
        
    }
    //收藏
    @IBAction func collect(sender: AnyObject) {
        
    }

    

}
