//
//  NQRecommendGameView.swift
//  DYTV
//
//  Created by djk on 17/3/14.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class NQRecommendGameView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义数据的属性
    var groups : [NQBaseModel]? {
        didSet {
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册Cell
        collectionView.register(UINib(nibName: "NQCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK:- 提供快速创建的类方法
extension NQRecommendGameView {
    class func recommendGameView() -> NQRecommendGameView {
        return Bundle.main.loadNibNamed("NQRecommendGameView", owner: nil, options: nil)?.first as! NQRecommendGameView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension NQRecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! NQCollectionGameCell
        
        cell.gameModel = groups![(indexPath as NSIndexPath).item]
        
        return cell
    }
}
