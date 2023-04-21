//
//  ViewController.swift
//  No TLS
//
//  Created by Hiro Protagonist on 4/20/23.
//

import UIKit

class ViewController: UIViewController, MenuItemManagerDelegate  {
    
    func didUpdateMenuItemData(_ menuItemManager: MenuItemManager, _ menuItemsModel: MenuItemModel) {
        DispatchQueue.main.async {
            self.menuItemLabel.text = "Updating..."
            menuItemsModel.menuItems.forEach { menuItem in
                print("menuItem in ViewController didUpdateMenuItemData: \(menuItem)")
                self.itemsString += "\(menuItem)\r"
                self.menuItems.append(menuItem)
            }
            self.menuItemLabel.text = self.itemsString
        }
    }
    
//    func didUpdateMenuItemData(_ menuItemManager: MenuItemManager, _ menuItemsModel: MenuItemModel) {
//        print("triggered didUpdateMenuItemData in ViewController")
//        print(menuItemsModel)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItemManager.delegate = self
    }
    
    var menuItems: [String] = []
    var itemsString: String = ""
    var menuItemManager = MenuItemManager()
    @IBOutlet weak var menuItemLabel: UILabel!
    
    @IBAction func fetchInsecurePressed(_ sender: Any) {
        menuItemLabel.text = "Processing..."
        menuItemManager.performRequest()
        print(menuItemManager.apiUrl)
    }
    
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
    
