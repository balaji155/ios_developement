//
//  UIHelperClass.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 04/09/25.
//

import UIKit

struct UIHelperClass {
    static func createThreeGridCollectionFlowLayout (in view: UIView) -> UICollectionViewFlowLayout {
        let screenWidth = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing:CGFloat = 10
        let availableWidth = screenWidth - (2 * padding) - (itemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
        
    }
}
