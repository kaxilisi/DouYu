//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by apple on 2016/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
//    class func creatItem(imageName:String,highImageName:String,size :CGSize) -> UIBarButtonItem{
//        let btn =  UIButton()
//        
//        btn.setImage(UIImage(named: imageName), forState: .Normal)
//        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
//        
//        btn.frame = CGRect(origin: CGPointZero ,size: size)
//        
//        return UIBarButtonItem(customView:btn)
//    }
    convenience init(imageName:String,highImageName:String,size :CGSize) {
        let btn =  UIButton()

        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)

        btn.frame = CGRect(origin: CGPointZero ,size: size)
        self.init(customView : btn)
    }
    
}