//
//  HomeViewController.swift
//  DYZB
//
//  Created by apple on 2016/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView :PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH )
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        
    }()
    
    fileprivate lazy var pageContentView :PageContentView = {[weak self] in
        let contentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentViewH)
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat( arc4random_uniform(255)), g: CGFloat( arc4random_uniform(255)), b: CGFloat( arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
    }

    

}

extension HomeViewController{
    fileprivate func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.blue
    }
    fileprivate func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: UIControlState())
        btn.sizeToFit()
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
        
        let size = CGSize(width: 40 , height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName:"btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName:"Image_scan", highImageName: "Image_scan_clicked", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
//
    }

    

    
}

extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }

}

extension HomeViewController :PagecontentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleVWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        print("000")
    }
}
