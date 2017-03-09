//
//  NQHomeViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class NQHomeViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : NQPageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = NQPageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    // MARK:- View加载
    override func viewDidLoad() {
        super.viewDidLoad()

       //设置UI界面
       setupUI()
    }

}

extension NQHomeViewController{
    fileprivate func setupUI(){
        
        //0.设置导航栏
        setupNavigationBar()
        
        //1.设置TitleView
        view.addSubview(pageTitleView)
    }
    
    func setupNavigationBar(){
        //0.不需要调整UIScrollVire的内边距
        automaticallyAdjustsScrollViewInsets = false;
        
        //1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let historyItem =  UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem =  UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem =  UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
