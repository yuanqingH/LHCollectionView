//
//  LHDemoRootHeaderItem.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootHeaderItem: LHCollectionReusableViewItem {
    var title : String = ""
    
    init(title: String, sectionIndex: Int) {
        super.init()
        self.title = title
        
        let width = UIScreen.main.bounds.width
        self.size = CGSize.init(width: width, height: 30)
        self.kind = .header
        self.sectionIndex = sectionIndex
    }
    
    override func mapReusableViewType() -> LHCollectionReusableView.Type {
        return LHDemoRootHeaderView.self
    }
}
