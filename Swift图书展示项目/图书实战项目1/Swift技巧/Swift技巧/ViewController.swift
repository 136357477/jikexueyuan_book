//
//  ViewController.swift
//  Swift技巧
//
//  Created by guohui on 16/6/3.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 属性观察
    @IBOutlet weak var myLabel: UILabel! {
        didSet {
        myLabel.textColor = UIColor.purpleColor()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

