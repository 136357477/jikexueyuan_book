//
//  BookCell.swift
//  Book
//
//  Created by guohui on 16/6/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import SDWebImage
class BookCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!

    @IBOutlet weak var rating: UIView!
    
    @IBOutlet weak var labelDetail: UILabel!

    //添加一个快捷方法
    func configureWithBook(book:Book)  {
        imageViewIcon.setResizeImageWith(book.image, width: imageViewIcon.frame.size.width)
//        rating.t
        labelTitle.text = book.title ;
        var detail = ""
        for str in book.author {
            detail += (str + "/")
        }
        labelDetail.text = detail + book.publisher + "/" + book.pubdate
        
    }
    
}
