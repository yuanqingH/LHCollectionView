//
//  LHCollectionViewDataSource.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHCollectionViewDataSource:NSObject,UICollectionViewDataSource {
    open var sectionItems:[[LHBaseItem]]? //多个section
    open var items:[LHBaseItem]?//一个section
    open var sectionViewItems : [LHCollectionReusableViewItem]?//section header footer对应的item数组
    
    public init(items:[LHBaseItem],sections:[LHCollectionReusableViewItem]? =  nil) {
        self.items = items
        self.sectionViewItems = sections
    }
    
    public init(sectionItems:[[LHBaseItem]],sections:[LHCollectionReusableViewItem]? =  nil) {
        self.sectionItems = sectionItems
        self.sectionViewItems = sections
    }
    
    //override
    open func collectionView(_ collectionView: UICollectionView, cellClassForObject object: LHBaseItem) -> LHCollectionViewCell.Type {
        return object.mapViewType()
    }
    
    // MARK: - 私有方法
    open func collectionView(_ collectionView: UICollectionView, objectForRowAtIndexPath indexPath: IndexPath) -> LHBaseItem? {
        var retItems = self.items
        if let section = self.sectionItems{
            if indexPath.section >= 0 && indexPath.section < section.count {
                retItems = section[indexPath.section]
            }
        }
        
        if let sourceItems = retItems{
            if indexPath.row >= 0 && indexPath.row < sourceItems.count {
                return sourceItems[indexPath.row]
            }
        }
        
        return nil
    }
    
    // MARK: - UICollectionViewDataSource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var retItems = self.items
        if let section1 = self.sectionItems{
            if section >= 0 && section < section1.count {
                retItems = section1[section]
            }
        }
        
        return retItems?.count ?? 0
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionItems?.count ?? 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let obj : LHBaseItem? = self.collectionView(collectionView, objectForRowAtIndexPath: indexPath)
        
        guard let object = obj  else {
            return UICollectionViewCell()
        }
        
        let cellType = self.collectionView(collectionView, cellClassForObject: object)
        let identifier = cellType.lhIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let cell2 = cell as? LHCollectionViewCell {
            cell2.setObject(object)
        }
        return cell;
    }
    
    
    
    
    
    
    
    ///MARK: - 设置collectionView各个section的header和footer
    
    open func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind:String, objectForSection section: Int) -> LHCollectionReusableViewItem?{
        return findReusableViewItem(kind, sectionIndex: section)
    }
    
    func findReusableViewItem(_ kind:String, sectionIndex: Int)->LHCollectionReusableViewItem?{
        guard let retItems = self.sectionViewItems else {
            return nil
        }
        let kind1 = LHCollectionReusableViewKind(rawValue: kind)
        for reusableViewItem in retItems{
            if reusableViewItem.sectionIndex == sectionIndex && reusableViewItem.kind == kind1 && !reusableViewItem.isHidden {
                return reusableViewItem
            }
        }
        
        return nil
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView!
        let object : LHCollectionReusableViewItem? = self.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, objectForSection: indexPath.section)
        if let obj = object {
            let viewType = self.collectionView(collectionView, reusableViewClassForObject: obj);
            let identifier = viewType.lhIdentifier()
            let kind = obj.kind
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: identifier, for: indexPath)
            
            let reusableView2 = reusableView as! LHCollectionReusableView
            reusableView2.setObject(obj)
        }else{
            //不能直接这样创建 使用基类的LHCollectionReusableView去替代这种情况
            //reusableView = LHCollectionReusableView()
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LHCollectionReusableView", for: indexPath)
        }
        
        return reusableView
        
    }
    
    //override
    open func collectionView(_ collectionView: UICollectionView, reusableViewClassForObject object: LHCollectionReusableViewItem) -> LHCollectionReusableView.Type {
        return object.mapReusableViewType()
    }
}
