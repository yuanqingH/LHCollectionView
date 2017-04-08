//
//  LHCollectionVCL.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

class LHCollectionVCL: LHScrollVCL,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak public var collectionView : UICollectionView?
    
    private var _dataSource:LHCollectionViewDataSource?
    public var dataSource:LHCollectionViewDataSource? {
        get {
            return _dataSource
        }
        set (newValue) {
            if newValue != _dataSource {
                _dataSource = newValue
            }
            self.collectionView?.dataSource = newValue
        }
    }
    
    deinit {
        self.collectionView?.delegate = nil
        self.collectionView?.dataSource = nil
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView?.collectionViewLayout = self.collectionViewLayout()
        // Do any additional setup after loading the view.
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func loadItems(){
        
    }
    
    open func createCollectionView(_ frame: CGRect){
        let layout = self.collectionViewLayout()
        let collection = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collection.backgroundColor = .white
        self.collectionView = collection
        self.view.addSubview(self.collectionView!)
        self.collectionView?.delegate = self
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView (_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.dataSource is LHCollectionViewDataSource) {
            let dc:LHCollectionViewDataSource = self.collectionView?.dataSource as! LHCollectionViewDataSource
            let object = dc.collectionView(collectionView, objectForRowAtIndexPath: indexPath)
            if let obj1 = object {
                let cellType = dc.collectionView(collectionView, cellClassForObject: obj1)
                return cellType.collectionView(collectionView, layout: collectionViewLayout, sizeForObject: obj1)
            }
        }
        return CGSize.zero
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
    
    //override
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if (collectionView.dataSource is LHCollectionViewDataSource) {
            let dc:LHCollectionViewDataSource = self.collectionView?.dataSource as! LHCollectionViewDataSource
            let object = dc.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, objectForSection: section)
            if let obj = object{
                let viewType = dc.collectionView(collectionView, reusableViewClassForObject: obj)
                return viewType.collectionView(collectionView: collectionView, layout: collectionViewLayout, sizeForObject: obj)
            }
        }
        return CGSize.zero
    }
    
    //override
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if (collectionView.dataSource is LHCollectionViewDataSource) {
            let dc:LHCollectionViewDataSource = self.collectionView?.dataSource as! LHCollectionViewDataSource
            let object = dc.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionFooter, objectForSection: section)
            if let obj = object{
                let viewType = dc.collectionView(collectionView, reusableViewClassForObject: obj)
                return viewType.collectionView(collectionView: collectionView, layout: collectionViewLayout, sizeForObject: obj)
            }
        }
        return CGSize.zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    //MARK: - Register Class
    open func registerClass(){
        if let collection = self.collectionView {
            LHCollectionReusableView.register(for: collection, kind: UICollectionElementKindSectionHeader)
            LHCollectionReusableView.register(for: collection, kind: UICollectionElementKindSectionFooter)

        }
    }
    
    //MARK: - 子类可以重写设置layout
    open func collectionViewLayout() -> UICollectionViewLayout{
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        return layout
    }
}
