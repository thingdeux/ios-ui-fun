//
//  AIIMenuItem.swift
//  adventures-in-ui
//
//  Created by Josh on 8/28/16.
//  Copyright © 2016 Josh.Land. All rights reserved.
//

enum AIIMenuType {
    case StaticTile
    case DynamicTile
    case PhysicsTile
}


struct AIIMenuItem {
    var labelText: String
    var menuItemType: AIIMenuType
//    var segueName: String
    init(named labelText: String, type: AIIMenuType) {
        self.labelText = labelText
        self.menuItemType = type
    }
}
