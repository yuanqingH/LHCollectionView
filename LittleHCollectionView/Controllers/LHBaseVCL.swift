//
//  LHBaseVCL.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit

open class LHBaseVCL: UIViewController {
    open var paramDict : [String:Any]?
    open var model : LHBaseModel!
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //传递参数
    open func setParameters(_ paramters : [String:Any]?){
        self.paramDict = paramters
    }
}
