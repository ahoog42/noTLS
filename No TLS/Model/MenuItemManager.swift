//
//  MenuItem.swift
//  No TLS
//
//  Created by Hiro Protagonist on 4/20/23.
//

import Foundation

protocol MenuItemManagerDelegate {
    func didUpdateMenuItemData(_ menuItemManager: MenuItemManager, _ menuItemsModel: MenuItemModel)
    func didFailWithError(error: Error)
}

struct MenuItemManager {
//    let apiUrl = "http://localhost:7001/api/menu/menuitems/"
    let apiUrl = "http://notls.andrewhoog.com/api/menu/menuitems/"

    var delegate: MenuItemManagerDelegate?
    
    func performRequest() {
        print("running MenuItemManager.performRequest")
        if let url = URL(string: apiUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let menuItemsModel = self.parseJson(safeData) {
                        delegate?.didUpdateMenuItemData(self, menuItemsModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ menuItemData: Data) -> MenuItemModel? {
        var resultsArr: [String] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([MenuItemData].self, from: menuItemData)
            decodedData.forEach { menuItem in
                print("In parseJson \(menuItem.name)")
                resultsArr.append(menuItem.name)
            }
            return MenuItemModel(menuItems: resultsArr)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


