//
//  NQHomeViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQHomeViewController: UIViewController {

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
