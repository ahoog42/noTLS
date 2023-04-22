//
//  ViewController.swift
//  No TLS
//
//  Created by Hiro Protagonist on 4/20/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MenuItemManagerDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath)
        
        //Default Content Configuration
        var content = cell.defaultContentConfiguration()
        content.text = menuItems[indexPath.item]
        
        cell.contentConfiguration = content
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItemManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var menuItems: [String] = []
    var itemsString: String = ""
    var menuItemManager = MenuItemManager()
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    func didUpdateMenuItemData(_ menuItemManager: MenuItemManager, _ menuItemsModel: MenuItemModel) {
        DispatchQueue.main.async {
            menuItemsModel.menuItems.forEach { menuItem in
                print("menuItem in ViewController didUpdateMenuItemData: \(menuItem)")
                self.itemsString += "\(menuItem)\r"
                self.menuItems.append(menuItem)
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func fetchInsecurePressed(_ sender: Any) {
        menuItemManager.performRequest()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

