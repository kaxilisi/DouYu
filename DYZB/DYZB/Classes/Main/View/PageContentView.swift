//
//  PageContentView.swift
//  DYZB
//
//  Created by apple on 2016/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

protocol PagecontentViewDelegate :class {
    func pageContentView(_ contentView :PageContentView  , progress:CGFloat , sourceIndex :Int ,targetIndex :Int )
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    fileprivate var childVcs :[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startContentOffsetX : CGFloat = 0
    weak var delegate : PagecontentViewDelegate?
    fileprivate var isForbidScrollDelegate :Bool  = false
    fileprivate lazy var collectionView :UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection  = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:ContentCellID )
        
//        collectionView.backgroundView = UIColor(r: <#T##CGFloat#>, g: <#T##CGFloat#>, b: <#T##CGFloat#>)
        return collectionView
    }()
    init(frame: CGRect,childVcs : [UIViewController],parentViewController: UIViewController?) {
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
    fileprivate func setupUI(){
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }

}

//MARK:-
extension PageContentView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for  view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }

}

//MARK:-
extension PageContentView{
    func setCurrentIndex(_ currentIndex : Int){
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startContentOffsetX = scrollView.contentOffset.x
        isForbidScrollDelegate = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startContentOffsetX {
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startContentOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else{
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}
