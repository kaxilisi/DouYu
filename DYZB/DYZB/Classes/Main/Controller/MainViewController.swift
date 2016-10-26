//
//  MainViewController.swift
//  DYZB
//
//  Created by apple on 2016/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
        
    }
    fileprivate func addChildVc(_ storyName:String){
        let childVc = UIStoryboard(name:storyName,bundle:nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }

}
