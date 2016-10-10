//
//  PageTitleView.swift
//  DYZB
//
//  Created by apple on 2016/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
private let scrollLineH :CGFloat = 2
class PageTitleView: UIView {
    
    private var titles : [String]
    private lazy var titleLabels :[UILabel] = [UILabel]()
    private lazy var scrollView :UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.scrollsToTop = false
//        scrollView.backgroundColor = UIColor.blueColor()
        return scrollView
        
    }()
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been imlemented" )
    }
    
}

extension PageTitleView{
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLebels()
        
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLebels(){
        let labelW :CGFloat = frame.width/CGFloat(titles.count)
        let labelH :CGFloat = frame.height - scrollLineH
        let labelY :CGFloat = 0
        for (index,title) in titles.enumerate() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center
            

            let labelX :CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRectMake(labelX, labelY, labelW, labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    private func  setupBottomLineAndScrollLine(){
        let  bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let  lineH : CGFloat = 0.5
        
        bottomLine.frame = CGRectMake(0, frame.height - lineH, frame.width, lineH)
        
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orangeColor()
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRectMake(firstLabel.frame.origin.x, frame.height - scrollLineH, firstLabel.frame.width, scrollLineH)
    }
}
