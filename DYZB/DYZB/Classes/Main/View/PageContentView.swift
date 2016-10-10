//
//  PageContentView.swift
//  DYZB
//
//  Created by apple on 2016/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVcs :[UIViewController]
    private var parentViewController:UIViewController
    
    private lazy var collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection  = .Horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        
        return collectionView
    }()
    init(frame: CGRect,childVcs : [UIViewController],parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been imlemented" )
    }

}

extension PageContentView{
    private func setupUI(){
        for childVc in childVcs {
            parentViewController.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }

}
