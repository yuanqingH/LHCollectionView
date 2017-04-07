//
//  LHDemoRootTypeTwoView.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootTypeTwoView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schemeImageView: UIImageView!
   
    final var _item : LHDemoRootTypeTwoItem?
    
    func setItem(item : LHDemoRootTypeTwoItem?){
        _item = item
        
        if let name = item?.title{
            self.nameLabel.text = name
        }
        
        if let imageName = item?.imageName {
            let image = UIImage.init(named: imageName)
            self.schemeImageView.image = image
        }
    }
    
}
