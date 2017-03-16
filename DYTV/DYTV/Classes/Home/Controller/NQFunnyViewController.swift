//
//  NQFunnyViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class NQFunnyViewController: NQAnchorViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var funnyVM : NQFunnyViewModel = NQFunnyViewModel()
}

extension  NQFunnyViewController{
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension  NQFunnyViewController{
    override func loadData() {
        //1.给父类中的ViewModel进行赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData{
            self.collectionView.reloadData()
        }
    }
}
