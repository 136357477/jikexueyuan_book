//
//  BookCell.swift
//  Book
//
//  Created by guohui on 16/2/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit
import SDWebImage
class BookCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var rating: UIView!
    
    @IBOutlet weak var labelDetail: UILabel!
    
    
    func configureWithBook(book:Book){
//        imageViewIcon?.sd_setImageWithURL(NSURL(string: book.image))
        //新建一个动态修改imageView的大小的扩展
        imageViewIcon.setResizeImageWith(book.image, width: imageViewIcon.frame.size.width);
                
        labelTitle.text = book.title

        var detail = ""
        for str in book.author{
            detail += (str + "/")
        }
        
        labelDetail.text = detail + book.publisher + "/" + book.pubdate
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
