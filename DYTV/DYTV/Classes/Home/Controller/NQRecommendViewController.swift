//
//  NQRecommendViewController.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class NQRecommendViewController: NQAnchorViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : NQRecommendViewModel =  NQRecommendViewModel()
    
    fileprivate lazy var cycleView : NQRecommendCycleView = {
        let cycleView = NQRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView  : NQRecommendGameView = {
        let gameView = NQRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
}

// MARK:- 设置UI界面
extension NQRecommendViewController{
    override func setupUI() {
        //1.先调用super.setupUI()
        super.setupUI()
        
        //2.设置collectionView的内边距
        collectionView.contentInset  = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        //3.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        //4.将gameView添加collectionView中
        collectionView.addSubview(gameView)
    }
}

// MARK:- 请求数据
extension NQRecommendViewController{
    override func loadData() {
        // 0.给父类中的ViewModel进行赋值
        baseVM = recommendVM
        
        //1.请求推荐数据
        recommendVM.requestData {
            //1.展示分组推荐界面
            self.collectionView.reloadData()
            
            //2.展示分组游戏界面
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = NQAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            //3.数据请求完成
            self.loadDataFinished()
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 重写父类方法
extension  NQRecommendViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
             //取出PrettyCell
             let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! NQCollectionPrettyCell
            //设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
             return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}

extension NQRecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

