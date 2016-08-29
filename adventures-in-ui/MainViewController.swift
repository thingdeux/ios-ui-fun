//
//  MainViewController.swift
//  adventures-in-ui
//
//  Created by Josh on 8/28/16.
//  Copyright © 2016 Josh.Land. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
    private let reuseIdentifier = "menuItem"
    private var customLayout: MainViewDropInLayout?
    private var menuItems: [AIIMenuItem] = []
    private var availableMenuItems: [AIIMenuItem] = [
        AIIMenuItem(named: "Jungle", type: .PhysicsTile),
        AIIMenuItem(named: "Book", type: .PhysicsTile),
        AIIMenuItem(named: "Freestyle", type: .PhysicsTile),
        AIIMenuItem(named: "Love", type: .PhysicsTile),
        AIIMenuItem(named: "Supreme", type: .PhysicsTile),
        AIIMenuItem(named: "Heart", type: .PhysicsTile),
        AIIMenuItem(named: "Kiss", type: .PhysicsTile),
        AIIMenuItem(named: "Style", type: .PhysicsTile),
        AIIMenuItem(named: "Disco", type: .PhysicsTile),
        AIIMenuItem(named: "Mango", type: .PhysicsTile),
        AIIMenuItem(named: "Cower", type: .PhysicsTile),
        AIIMenuItem(named: "Large", type: .PhysicsTile),
        AIIMenuItem(named: "Gungnir", type: .PhysicsTile),
        AIIMenuItem(named: "Snake", type: .PhysicsTile),
        AIIMenuItem(named: "Ocelot", type: .PhysicsTile),
        AIIMenuItem(named: "Raiden", type: .PhysicsTile),
        AIIMenuItem(named: "Book", type: .PhysicsTile),
        AIIMenuItem(named: "Adam", type: .PhysicsTile),
        AIIMenuItem(named: "Raul", type: .PhysicsTile),
        AIIMenuItem(named: "Josh", type: .PhysicsTile)
    ]
    private var isAnimatingInsertion: Bool = false
    private let delayBeforeQueuingInsertion = 0.04
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = CGRectGetWidth(collectionView!.frame) / 3
        self.customLayout = collectionViewLayout as? MainViewDropInLayout
        self.customLayout!.itemSize = CGSize(width: width, height: width)
        self.queueMenuItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Add Menu Items to main collection view.  Make sure only one gets added at a time
    /// Else the collection view will crash HARD.
    private func queueMenuItem() {
        if self.availableMenuItems.count > 1 {
            if (self.isAnimatingInsertion == false) {
                if let menuItem = self.availableMenuItems.popLast() {
                    self.isAnimatingInsertion = true
                    self.menuItems.append(menuItem)
                    dispatchOnMainQueue(seconds: delayBeforeQueuingInsertion, dispatchBlock: {
                        self.animateMenuItem(menuItem)
                    })
                }
            } else {
                dispatchOnMainQueue(seconds: delayBeforeQueuingInsertion, dispatchBlock: {
                    self.queueMenuItem()
                })
            }
        }
    }
    
    private func animateMenuItem(item: AIIMenuItem) {
        let layout = self.collectionViewLayout as! MainViewDropInLayout
        let lastAddedItemIndex = self.menuItems.count - 1
        let indexPath = NSIndexPath(forItem: lastAddedItemIndex, inSection: 0)
        layout.appearingIndexPath = indexPath
        
        if (self.menuItems.count <= 1) {
            self.collectionView?.reloadData()
            self.isAnimatingInsertion = false
            dispatchOnMainQueue(seconds: delayBeforeQueuingInsertion, dispatchBlock: {
                self.queueMenuItem()
            })
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
                    self.collectionView!.insertItemsAtIndexPaths([indexPath])
                }) { (finished) in
                    layout.appearingIndexPath = nil
                    self.isAnimatingInsertion = false
                    dispatchOnMainQueue(seconds: self.delayBeforeQueuingInsertion, dispatchBlock: {
                        self.queueMenuItem()
                    })
                }
            }
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension MainViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainViewCollectionViewCell
        let menuItem = self.menuItems[indexPath.row]
        cell.textLabel.text = menuItem.labelText
        return cell
    }
}

// MARK: Custom Layout
extension MainViewController {
    
}

// MARK: UICollectionViewDelegate

extension MainViewController {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */

}
