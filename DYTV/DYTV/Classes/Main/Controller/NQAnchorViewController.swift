//
//  NQAnchorViewController.swift
//  DYTV
//
//  Created by djk on 17/3/10.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

// MARK:- 定义NQAnchorViewController类
class NQAnchorViewController: NQBaseViewController {
    // MARK:- 定义属性
    var baseVM : NQBaseViewModel!
    
    // MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView  = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //把当前控制器的view添加到不同大小的其他view里时,设置自动拉伸大小
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "NQCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "NQCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "NQCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        //请求数据
        loadData()
    }
}

// MARK:- 设置UI界面
extension NQAnchorViewController{
     override func setupUI(){
        //1.给父类中内容View的引用进行赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        
        //3.调用super.setupUI()
        super.setupUI()
    }
}

// MARK:- 请求数据
extension NQAnchorViewController{
    func loadData(){
        
    }
}

// MARK:- 遵守UICollectionView的数据源
extension  NQAnchorViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVM == nil {
            return 3
        }
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM == nil {
            return 5
        }
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NQCollectionNormalCell
        
        if baseVM == nil {
            return cell
        }
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)as! NQCollectionHeaderView
        
        if baseVM == nil {
            return headerView
        }
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension  NQAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc(){
        //1.创建showRoomVc
        let showRoomVc = NQRoomShowViewController()
        
        //2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVc(){
        //1.创建NormalRoomVc
        let normalRoomVc = NQRoomNormalViewController()
        
        //2.以Push方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}
