//
//  MenuItemModel.swift
//  No TLS
//
//  Created by Hiro Protagonist on 4/20/23.
//

import Foundation

struct MenuItemModel {
    let menuItems: [String]
    
    func getCount() -> Int {
        return menuItems.count
    }
}
