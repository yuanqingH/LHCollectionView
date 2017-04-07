//
//  LHDemoRootVCL.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHDemoRootVCL: LHCollectionDealVCL {

    override open func viewDidLoad() {
        super.viewDidLoad()
        if self.collectionView == nil {
            let rect = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 64)
            self.createCollectionView(rect)
            
            //
            //self.collectionView?.collectionViewLayout = LHCollectionViewStickFlowLayout()
        }
        
        self.registerClass()
        self.model = LHDemoRootModel()
        
        self.loadItems()
    }
    
    
    override func loadItems() {
        self.model.loading = true
        self.model.loadItems(nil, completion: { [weak self] _ in
            self?.model.loading = false
            self?.reloadData()
        }) { [weak self] _ in
            self?.model.loading = false
            self?.resetLoadMoreState()
        }
    }
    
    override func reloadData() {
        guard let items =  self.model?.items else {
            return
        }
        self.resetLoadState()
//        let headerItem = LHDemoRootHeaderItem.init(title: "I AM HEADER",sectionIndex:0)
//        self.model.sections.append(headerItem)
        //let ds = LHCollectionViewDataSource.init(items:items as! [LHBaseItem], sections:self.model?.sections)
        let ds = LHCollectionViewDataSource.init(sectionItems: items as! [[LHBaseItem]], sections:self.model.sections)
        self.dataSource = ds
    }
    
    
    ///MARK: - RegisterClass
    override open func registerClass() {
        super.registerClass()
        if let collection =  self.collectionView {
            LHDemoRootTypeOneCell.register(for: collection)
            LHDemoRootTypeTwoCell.register(for: collection)
            LHDemoRootHeaderView.register(for: collection, kind: UICollectionElementKindSectionHeader)
            LHDemoRootFooterView.register(for: collection, kind: UICollectionElementKindSectionFooter)
        }
        
    }

}
