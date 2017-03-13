//
//  NQPageContentView.swift
//  DYTV
//
//  Created by djk on 17/3/9.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol  NQPageContentViewDelegate : class {
    func pageContentView(_ contentView : NQPageContentView,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
}

// MARK:- 定义常量
private let ContentCellID = "ContentCellID"

// MARK:- 定义PageContentView类
class NQPageContentView: UIView {
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : NQPageContentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //0.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //0.记录执行代理方法
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否需要执行代理方法
        if isForbidScrollDelegate{return}
        
        //1.定义需要的数据
        var progress : CGFloat = 0
        var soureIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if  currentOffsetX > startOffsetX{//左滑
            //1.计算progress
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            //2.计算sourceIndex
            soureIndex = Int(currentOffsetX/scrollViewW)
            //3.计算targetIndex
            targetIndex = soureIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = soureIndex
            }
        }else{
            //1.计算progress
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            //2.计算sourceIndex
            targetIndex = Int(currentOffsetX/scrollViewW)
            //3.计算targetIndex
            soureIndex = targetIndex + 1
            if soureIndex >= childVcs.count{
                soureIndex = childVcs.count - 1
            }
            //4.如果完全划过去
            if startOffsetX - currentOffsetX == scrollViewW{
                progress = 1
                soureIndex = targetIndex
            }
        }
        
//        print("currentOffsetX\(currentOffsetX)---startOffsetX\(startOffsetX)---soureIndex\(soureIndex)---targetIndex\(targetIndex)")
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: soureIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension NQPageContentView{
    func setCurrentIndex(_ currentIndex : Int){
        //0.记录不执行代理方法
        isForbidScrollDelegate = true
        //1.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}




