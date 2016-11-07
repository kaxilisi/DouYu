//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by apple on 2016/11/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    //MARK:控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK:系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RecommendCycleView{
    class func recommendCycleView() ->RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }

}
