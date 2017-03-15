//
//  NQAmuseMenuView.swift
//  DYTV
//
//  Created by djk on 17/3/15.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class NQAmuseMenuView: UIView {

    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!


    // MARK: 定义属性
    var groups : [NQAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "NQCollectionAmuseCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK:- 提供快速创建的类方法
extension NQAmuseMenuView {
    class func amuseMenuView() -> NQAmuseMenuView {
        return Bundle.main.loadNibNamed("NQAmuseMenuView", owner: nil, options: nil)?.first as! NQAmuseMenuView
    }
}

extension  NQAmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1)/8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! NQCollectionAmuseCell
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1)*8 - 1
        // 2.判断越界问题
        if endIndex > groups!.count - 1{
            endIndex = groups!.count - 1
        }
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
        
        return cell
    }
}

extension NQAmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
    }
}

