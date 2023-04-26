//
//  ViewController.swift
//  No TLS
//
//  Created by Hiro Protagonist on 4/20/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MenuItemManagerDelegate  {
    
    var menuItems: [String] = []
    var menuItemManager = MenuItemManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuItemManager.delegate = self

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Got Location Data")
            locationManager.startUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lat: \(lat)")
            print("lon: \(lon)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting locations")
        print(error)
    }
    
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
    
    func didUpdateMenuItemData(_ menuItemManager: MenuItemManager, _ menuItemsModel: MenuItemModel) {
        DispatchQueue.main.async {
            self.menuItems = []
            menuItemsModel.menuItems.forEach { menuItem in
                print("menuItem in ViewController didUpdateMenuItemData: \(menuItem)")
                self.menuItems.append(menuItem)
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func fetchInsecurePressed(_ sender: Any) {
        menuItemManager.performRequest()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    

    @IBAction func personPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoProfile", sender: self)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gotoProfile" {
            let destinationVC = segue.destination as! ProfileViewController
        }
    }
}
