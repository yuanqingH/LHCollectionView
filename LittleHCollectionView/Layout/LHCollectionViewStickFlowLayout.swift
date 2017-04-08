//
//  LHCollectionViewStickFlowLayout.swift
//  LittleHCollectionViewDemo
//
//  Created by huangyuanqing on 2017/4/7.
//  Copyright © 2017年 huangyuanqing. All rights reserved.
//

//ios9之前collectionview不支持悬停 使用这个layout悬停
import UIKit

public let kStickFlowLayoutSectionZPosition:Int = 7

open class LHCollectionViewStickFlowLayout: UICollectionViewFlowLayout {
    open var stickOffset:CGFloat = 0;
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //UICollectionViewLayoutAttributes：我称它为collectionView中的item（包括cell和header、footer这些）的《结构信息》
        
        //截取到父类所返回的数组（里面放的是当前屏幕所能展示的item的结构信息）
        let superArray = super.layoutAttributesForElements(in: rect);
        guard var returnArray = superArray else {
            return nil;
        }
        guard let collectionView = self.collectionView else {
            return nil;
        }
        
        
        //创建存索引的数组，无符号（正整数），无序（不能通过下标取值），不可重复（重复的话会自动过滤）
        var noneHeaderSections: IndexSet = IndexSet();
        
        //遍历returnArray，得到一个当前屏幕中所有的section数组
        for attributes in returnArray {
            //如果当前的元素分类是一个cell，将cell所在的分区section加入数组，重复的话会自动过滤
            if attributes.representedElementCategory == .cell {
                noneHeaderSections.insert(attributes.indexPath.section);
            }
        }
        
        //遍历returnArray，将当前屏幕中拥有的header的section从数组中移除，得到一个当前屏幕中没有header的section数组
        //正常情况下，随着手指往上移，header脱离屏幕会被系统回收而cell尚在，也会触发该方法
        for attributes in returnArray {
            //如果当前的元素是一个header，将header所在的section从数组中移除
            if attributes.representedElementKind == UICollectionElementKindSectionHeader {
                noneHeaderSections.remove(attributes.indexPath.section);
            }
        }
        
        //遍历当前屏幕中没有header的section数组
        for idx in noneHeaderSections {
            //取到当前section中第一个item的indexPath
            let indexPath = IndexPath.init(item: 0, section: idx);
            //获取当前section在正常情况下已经离开屏幕的header结构信息
            let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath);
            
            //如果当前section确实有因为离开屏幕而被系统回收的header
            if let sectionAttributes = attributes {
                //将该header结构信息重新加入到returnArray中去
                returnArray.append(sectionAttributes);
            }
        }
        
        //遍历returnArray，改变header结构信息中的参数，使它可以在当前section还没完全离开屏幕的时候一直显示
        for attributes in returnArray {
            //如果当前item是header
            guard attributes.representedElementKind == UICollectionElementKindSectionHeader else {
                continue;
            }
            
            //得到当前header所在分区的cell的数量
            let numberOfItemsInSection = collectionView.numberOfItems(inSection: attributes.indexPath.section);
            //得到第一个item的indexPath
            let firstItemIndexPath = IndexPath.init(item: 0, section: attributes.indexPath.section);
            //得到最后一个item的indexPath
            let lastItemIndexPath = IndexPath.init(item: max(0, numberOfItemsInSection-1) , section: attributes.indexPath.section);
            
            //得到第一个item和最后一个item的结构信息
            var firstItemAttributes,lastItemAttributes:UICollectionViewLayoutAttributes;
            if numberOfItemsInSection>0 {
                //cell有值，则获取第一个cell和最后一个cell的结构信息
                firstItemAttributes = self.layoutAttributesForItem(at: firstItemIndexPath)!;
                lastItemAttributes = self.layoutAttributesForItem(at: lastItemIndexPath)!;
            }else {
                //cell没值,就新建一个UICollectionViewLayoutAttributes
                firstItemAttributes = UICollectionViewLayoutAttributes();
                
                //然后模拟出在当前分区中的有唯一一个cell
                if self.scrollDirection == .vertical {
                    //cell在header的下面，高度为0，还与header隔着可能存在的sectionInset的top
                    let y = attributes.frame.maxY+self.sectionInset.top;
                    firstItemAttributes.frame = CGRect.init(x: 0, y: y, width: 0, height: 0);
                }else {
                    //cell在header的右面，宽度为0，还与header隔着可能存在的sectionInset的left
                    let x = attributes.frame.maxX+self.sectionInset.left;
                    firstItemAttributes.frame = CGRect.init(x: x, y: 0, width: 0, height: 0);
                }
                lastItemAttributes = firstItemAttributes;
            }
            
            //获取当前header的frame
            var headerRect = attributes.frame;
            
            if self.scrollDirection == .vertical {
                //当前的滑动距离 + 想要置顶的偏移量（根据需求不同，需自己设置，默认为0）
                let offset = collectionView.contentOffset.y + stickOffset;
                //计算当前section原本的frame.origin.y, 第一个cell的y值 - (当前header的高度 + 可能存在的sectionInset的top)
                let headerTopY = firstItemAttributes.frame.minY - (headerRect.height + self.sectionInset.top);
                
                //哪个大取哪个，保证header悬停，针对当前header(即悬停header)基本上都是offset更加大，针对下一个header则会是headerOffsetY大，各自处理
                let maxY = max(offset,headerTopY);
                
                //计算当前section最大的悬停frame.origin.y,即当前section的footer或者下一个section接触到当前header的底部，此时的偏移量即 最后一个cell的maxY + 可能存在的sectionInset的bottom - 当前header的高度
                let headerMissingY = lastItemAttributes.frame.maxY + self.sectionInset.bottom - headerRect.size.height;
                
                //给rect的y赋新值，因为在最后消失的临界点要跟谁消失，所以取小
                headerRect.origin.y = min(maxY,headerMissingY);
            }else {
                let offset = collectionView.contentOffset.x + stickOffset;
                let headerLeftX = firstItemAttributes.frame.minX - (headerRect.width + self.sectionInset.left);
                let maxX = max(offset,headerLeftX);
                let headerMissingX = lastItemAttributes.frame.maxX + self.sectionInset.right - headerRect.size.width;
                headerRect.origin.x = min(maxX,headerMissingX);
            }
            //给header的结构信息的frame重新赋值
            attributes.frame = headerRect;
            
            //如果按照正常情况下,header离开屏幕被系统回收，而header的层次关系又与cell相等，如果不去理会，会出现cell在header上面的情况
            //通过打印可以知道cell的层次关系zIndex数值为0，我们可以将header的zIndex设置成1，如果不放心，也可以将它设置成非常大
            attributes.zIndex = kStickFlowLayoutSectionZPosition;
        }
        
        return returnArray;
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
}
