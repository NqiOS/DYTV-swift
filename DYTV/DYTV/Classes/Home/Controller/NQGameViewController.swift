//
//  NQGameViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 5 / 5
private let kHeaderViewH : CGFloat = 40

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class NQGameViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var  gameVM : NQGameViewModel = NQGameViewModel()
    
    fileprivate lazy var topHeaderView : NQCollectionHeaderView = {
        let headerView = NQCollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH+kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : NQRecommendGameView = {
        let gameView = NQRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var  collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "NQCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "NQCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI界面
extension NQGameViewController{
    fileprivate func setupUI(){
        //1.添加UICollectionView
        view.addSubview(collectionView)
        //2.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        //3.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        //4.将常用游戏的View,添加到collectionView中
        collectionView.addSubview(gameView)
    }
}

// MARK:- 请求数据
extension NQGameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData { 
            //1.展示全部游戏
            self.collectionView.reloadData()
            //2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

// MARK:- 遵守UICollectionView的数据源&代理
extension NQGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! NQCollectionGameCell
        
        cell.gameModel = gameVM.games[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! NQCollectionHeaderView
        
        // 2.给HeaderView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}
