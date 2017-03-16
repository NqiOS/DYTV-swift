//
//  NQAmuseViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class NQAmuseViewController: NQAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : NQAmuseViewModel = NQAmuseViewModel()
    fileprivate lazy var menuView : NQAmuseMenuView = {
        let menuView = NQAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

// MARK:- 设置UI界面
extension NQAmuseViewController{
    override func setupUI() {
        //1.先调用super.setupUI()
        super.setupUI()
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        //添加菜单view到collectionView中
        collectionView.addSubview(menuView)
    }
}

// MARK:- 请求数据
extension NQAmuseViewController{
    override func loadData() {
        // 0.给父类中的ViewModel进行赋值
        baseVM = amuseVM
        
        //1.请求数据
        amuseVM.loadAmuseData {
            //1.刷新下部分组界面
            self.collectionView.reloadData()
            
            //2.赋值上部表格数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}
