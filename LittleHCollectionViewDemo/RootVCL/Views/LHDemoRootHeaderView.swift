//
//  LHDemoRootHeaderView.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootHeaderView: LHCollectionReusableView {

    var titleLabel : UILabel?
    
    override func setObject(_ obj: LHBaseItem) {
        super.setObject(obj)
        if obj is LHDemoRootHeaderItem {
            let homeItem = obj as! LHDemoRootHeaderItem
            self.titleLabel?.text = homeItem.title
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.addTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTitleLabel(){
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .brown
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        self.titleLabel = titleLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let homeItem = self.item as! LHDemoRootHeaderItem
        self.titleLabel?.frame = CGRect.init(origin: CGPoint.zero, size: homeItem.size)
    }

}
