//
//  NQCollectionAmuseCell.swift
//  DYTV
//
//  Created by djk on 17/3/15.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kkGameCellID = "kkGameCellID"

class NQCollectionAmuseCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义属性
    var groups : [NQAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
       collectionView.register(UINib(nibName: "NQCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kkGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension NQCollectionAmuseCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.求出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kkGameCellID, for: indexPath) as! NQCollectionGameCell
        
        // 2.给Cell设置数据
        cell.gameModel = groups![indexPath.item]
        
        return cell
    }
}
