//
//  NQPageContentView.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit
// MARK:- 定义常量
private let ContentCellID = "ContentCellID"

// MARK:- 定义PageContentView类
class NQPageContentView: UIView {
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentViewController : UIViewController?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {
        //0.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //1.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect,childVcs : [UIViewController],parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension NQPageContentView{
    fileprivate func setupUI(){
        //1.添加所有子控制器到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器的View
        collectionView.frame = bounds
        addSubview(collectionView)
        
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension NQPageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //1.添加子控制器的view
        //涉及到cell重用
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

// MARK:- 遵守UICollectionViewDelegate
extension NQPageContentView : UICollectionViewDelegate{
    
}



