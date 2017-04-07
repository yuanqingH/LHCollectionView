//
//  LHDemoRootTypeOneItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootTypeOneItem: LHBaseItem {
    var bgColor : UIColor = UIColor.white
    var text : String = ""
    
    init(backgroundColor : UIColor, text : String) {
        super.init()
        self.text = text
        self.bgColor = backgroundColor
        
        let width = UIScreen.main.bounds.width
        let cellWidth = width - 10;
        self.size = CGSize.init(width: cellWidth, height: 50)
    }
    
    override func mapViewType() -> LHCollectionViewCell.Type {
        return LHDemoRootTypeOneCell.self
    }
}
