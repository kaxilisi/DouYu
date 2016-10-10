//
//  PageTitleView.swift
//  DYZB
//
//  Created by apple on 2016/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
// MARK:-
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView ,selectedIndex index: Int)
}


// MARK:-
private let scrollLineH :CGFloat = 2
private let kNormalColor :(CGFloat, CGFloat,CGFloat)  = (85,85,85)
private let kSelectColor :(CGFloat, CGFloat,CGFloat)  = (255,120,0)


// MARK:-


class PageTitleView: UIView {
    
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .Center
            

            let labelX :CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRectMake(labelX, labelY, labelW, labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //添加手势
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func  setupBottomLineAndScrollLine(){
        let  bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let  lineH : CGFloat = 0.5
        
        bottomLine.frame = CGRectMake(0, frame.height - lineH, frame.width, lineH)
        
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRectMake(firstLabel.frame.origin.x, frame.height - scrollLineH, firstLabel.frame.width, scrollLineH)
    }
}

//MARK:- 
extension PageTitleView{
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titleLabels[currentIndex]
        
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let  scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animateWithDuration(0.3){
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleVWithProgress(progress : CGFloat ,sourceIndex : Int , targetIndex :Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g:kSelectColor.1 - colorDelta.1 * progress, b:kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g:kNormalColor.1 + colorDelta.1 * progress, b:kNormalColor.2 + colorDelta.2 * progress)
        currentIndex = targetIndex
    }
}

