//
//  RecommendViewController.swift
//  DYZB
//
//  Created by apple on 2016/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    private lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(kItemW, kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        collectionView.registerNib(UINib(nibName: "CollectionNoramlCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
//        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor.purpleColor()
        setupUI()
        

    }


}


//MARK:-设置UI界面内容
extension RecommendViewController{
    private func setupUI(){
        view.addSubview(collectionView)
    }
    
}

extension RecommendViewController : UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        return 4
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath)
//        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerview = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath)
//        headerview.backgroundColor = UIColor.orangeColor()
        return headerview
    }
}

