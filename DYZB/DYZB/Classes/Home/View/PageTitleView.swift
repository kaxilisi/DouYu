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
    func pageTitleView(_ titleView : PageTitleView ,selectedIndex index: Int)
}


// MARK:-
private let scrollLineH :CGFloat = 2
private let kNormalColor :(CGFloat, CGFloat,CGFloat)  = (85,85,85)
private let kSelectColor :(CGFloat, CGFloat,CGFloat)  = (255,120,0)


// MARK:-


class PageTitleView: UIView {
    
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate lazy var titleLabels :[UILabel] = [UILabel]()
    fileprivate lazy var scrollView :UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.scrollsToTop = false
//        scrollView.backgroundColor = UIColor.blueColor()
        return scrollView
        
    }()
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
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
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLebels()
        
        setupBottomLineAndScrollLine()
    }
    fileprivate func setupTitleLebels(){
        let labelW :CGFloat = frame.width/CGFloat(titles.count)
        let labelH :CGFloat = frame.height - scrollLineH
        let labelY :CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            

            let labelX :CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    fileprivate func  setupBottomLineAndScrollLine(){
        let  bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.lightGray
        let  lineH : CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineH, width: firstLabel.frame.width, height: scrollLineH)
    }
}

//MARK:- 
extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titleLabels[currentIndex]
        
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let  scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleVWithProgress(_ progress : CGFloat ,sourceIndex : Int , targetIndex :Int){
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

