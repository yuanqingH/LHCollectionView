//
//  LHDemoRootTypeTwoItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootTypeTwoItem: LHBaseItem {
    var imageName : String?
    var title : String = ""
    
    init(title : String, imageName:String?) {
        super.init()
        self.title = title
        self.imageName = imageName
        
        let width = UIScreen.main.bounds.width
        let cellWidth = (width - 15)/2;
        
        self.size = CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    override func mapViewType() -> LHCollectionViewCell.Type {
        return LHDemoRootTypeTwoCell.self
    }
}
