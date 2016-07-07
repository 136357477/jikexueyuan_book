//
//  BookSearchController.swift
//  Book
//
//  Created by guohui on 16/6/17.
//  Copyright © 2016年 guohui. All rights reserved.
//

import UIKit

class BookSearchController: UIViewController,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource {
    //添加对之前 BookViewController 的引用 ,因为需要返回它做一些数据的处理
    //MARK: - Property -
    weak var bookController:BookViewController!
    var  searchController = UISearchController() //先构建一个 UISearchController 然后在awakeFromNib 进行配置
    let SearchPlaceholder = "搜索图书"
    var searchTitles = [String]() //搜索结果的文本数组
    
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!

    
    
    
    override func awakeFromNib() {
        searchController = UISearchController(searchResultsController: self)//这个UISearchViewController 显示结果的,是利用我们当前的 BookSearchController 做他的显示结果,做他的显示 UI
        searchController.searchResultsUpdater = self //数据更新也是我们的 searchController
        //为 searchbar添加一个 plachholder 提示字符串
        searchController.searchBar.placeholder = SearchPlaceholder
        //设置取消按钮为白色
        searchController.searchBar.tintColor = UIColor.whiteColor()
        //searchViewController 默认有一个背景颜色,我们不需要这个背景,所以把他删掉
        searchController.searchBar.subviews[0].subviews[0].removeFromSuperview()
    }
    
    
    
    //MARK: - UISearchResultsUpdating -
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // 搜索的关键字 如果搜索的关键字存在,并且不是空格或者换行
        if let tag = searchController.searchBar.text?.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet()) where !tag.isEmpty {
            //这里面需要向服务器请求数据,并刷新列表
            NetManager.getBookTitles(tag, page: 0, resultClosure: { (titles) in
                self.searchTitles = titles
                self.tableView.reloadData()
            })
        }
    }
    
    
    //MARK: - UITableView -
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //方法中构造单元格
        let cell = UITableViewCell()
        cell.textLabel?.text = searchTitles[indexPath.row]
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTitles.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchController.active = false
        bookController.tag = searchTitles[indexPath.row] //
        bookController.tableView.headerBeginRefresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
