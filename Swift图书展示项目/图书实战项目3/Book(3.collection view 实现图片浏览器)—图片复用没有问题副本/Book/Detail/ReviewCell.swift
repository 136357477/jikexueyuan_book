//
//  ReviewCell.swift
//  Book
//
//  Created by guohui on 16/6/28.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var imageViewHead: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewRatingContent: UIView!
    @IBOutlet weak var labelSummary: UILabel! // 评论内容
    @IBOutlet weak var labelRatingNum: UILabel! //评论数量
    @IBOutlet weak var labelDate: UILabel! //评论时间
    
    func configureWithReview(review:Review) -> Void {
        imageViewHead.sd_setImageWithURL(NSURL(string: review.author.avatar))
        labelTitle.text = review.title
        labelName.text = review.author.name
        if let rating = review.rating {
            RatingView.showInView(viewRatingContent, value: rating.averager)
            labelRatingNum.text = Int(rating.numRaters).description //int 转为 string
            
        }else{
            //没有评分
            RatingView.showNoRating(viewRatingContent)
        }
        labelSummary.text = review.summary
        labelDate.text = review.updated
    }

}
