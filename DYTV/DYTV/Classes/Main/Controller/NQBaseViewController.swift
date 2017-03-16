//
//  NQBaseViewController.swift
//  DYTV
//
//  Created by djk on 17/3/16.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

class NQBaseViewController: UIViewController {
    // MARK:- 定义属性
    var contentView : UIView?
    
    // MARK:- 懒加载属性
    fileprivate lazy var animageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- 设置UI界面
extension  NQBaseViewController{
    func setupUI(){
        //1.隐藏内容的View
        contentView?.isHidden = true
        
        //2.添加执行动画的UIImageView
        view.addSubview(animageView)
        
        //3.执行动画
        animageView.startAnimating()
        
        //4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished(){
        //1.停止动画
        animageView.stopAnimating()
        
        //2.隐藏animageView
        animageView.isHidden = true
        
        //3.显示内容的View
        contentView?.isHidden = false
    }
}
