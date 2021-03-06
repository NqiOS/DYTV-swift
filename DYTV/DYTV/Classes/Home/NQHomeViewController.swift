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
    fileprivate lazy var pageTitleView : NQPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = NQPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : NQPageContentView = {[weak self] in
        //0.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //1.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(NQRecommendViewController())
        childVcs.append(NQGameViewController())
        childVcs.append(NQAmuseViewController())
        childVcs.append(NQFunnyViewController())
        
        let contentView = NQPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
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
        
        //2.添加ContentView
        view.addSubview(pageContentView)
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

// MARK:- 遵守PageTitleViewDelegate协议
//点击pageTitleView里的label
extension NQHomeViewController : NQPageTitleViewDelegate{
    func pageTitleView(_ titleView: NQPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
//滑动pageContentView
extension NQHomeViewController : NQPageContentViewDelegate{
    func pageContentView(_ contentView: NQPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

