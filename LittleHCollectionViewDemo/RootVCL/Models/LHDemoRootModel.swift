//
//  LHDemoRootModle.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

import UIKit
enum myError: Error {
    case none
    case failed
    case goAway
}

class LHDemoRootModel: LHCollectionDealModel {
    var testErrorCount = 3
    
    override func loadItems(_ parameters: [String : Any]?, completion: @escaping ([String : Any]?) -> Void, failure: @escaping (Error) -> Void) {
        if self.pageNumber == 1 {
            self.items.removeAll()
            self.sections.removeAll()
        }
        
        print("当前请求 pageNumber == \(self.pageNumber)")
        
        //模拟第四页出错 3次
        if self.pageNumber == 4 && testErrorCount > 0{
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                DispatchQueue.main.async {
                    self.testErrorCount -= 1
                    let error = myError.failed
                    failure(error)
                }
            }
            return
        }
        
        self.tempData()
        
        //self.tempDataOneSection()
        
        //模拟第一页立刻出现
        if pageNumber == 1{
            self.hasNext = self.pageNumber < 7
            completion(nil)
            return
        }
        
        //模拟每页数据返回2s延时
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.hasNext = self.pageNumber < 7
                completion(nil)
            }
        }
    }
    
    
    func tempData(){
        var atomItems: [LHBaseItem] = []
        for i in 0...20{
            if i % 3 != 0{
                let tItem = LHDemoRootTypeTwoItem.init(title: "阿狸-\(i)", imageName: "LHDemoRootImageOne.png")
                atomItems.append(tItem)
            }else{
                let colorFloat = CGFloat(i) * 0.04 + 0.2
                let oItem = LHDemoRootTypeOneItem.init(backgroundColor: UIColor.init(white: colorFloat, alpha: 1.0), text: "DEMO-BACKGROUNDCOLOR\(colorFloat)")
                atomItems.append(oItem)
            }
        }
        
        if self.pageNumber % 2 == 0{
            let headerItem = LHDemoRootHeaderItem.init(title: "I AM HEADER OF SECTION \(self.pageNumber - 1)",sectionIndex:(self.pageNumber-1))
            self.sections.append(headerItem)
        }
        
        self.items.append(atomItems)
    }
    
    func tempDataOneSection(){
        for i in 0...20{
            if i % 3 != 0{
                let tItem = LHDemoRootTypeTwoItem.init(title: "阿狸-\(i)", imageName: "LHDemoRootImageOne.png")
                self.items.append(tItem)
            }else{
                let colorFloat = CGFloat(i) * 0.04 + 0.2
                let oItem = LHDemoRootTypeOneItem.init(backgroundColor: UIColor.init(white: colorFloat, alpha: 1.0), text: "DEMO-BACKGROUNDCOLOR\(colorFloat)")
                self.items.append(oItem)
            }
        }
    }
}
