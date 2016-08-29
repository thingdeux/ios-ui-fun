//
//  MainViewDropInLayout.swift
//  adventures-in-ui
//
//  Created by Josh on 8/28/16.
//  Copyright © 2016 Josh.Land. All rights reserved.
//

import UIKit

class MainViewDropInLayout: UICollectionViewFlowLayout {
    var appearingIndexPath: NSIndexPath?
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // Make sure the index path matches the one that's appearing
        guard let attributes = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath),
            indexPath = appearingIndexPath where indexPath == itemIndexPath else {
            return nil
        }
        
        let collectionViewHeight = CGRectGetHeight(collectionView!.frame)
        attributes.alpha = 1.0
        attributes.hidden = false
        attributes.center = CGPoint(x: attributes.center.x, y: collectionViewHeight + (attributes.frame.height))
        return attributes        
    }
    
    
}
