//
//  DistrictTableViewController.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

protocol DistrictTableViewControllerProtocol: class {
  func findLocationWithDistrict(district: District, type: TypeSelected)
}

class DistrictTableViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  weak var delegate: DistrictTableViewControllerProtocol?
  
  var cellNibName: String = "DistrictCell"
  
  var dataViewable: DataViewableProtocol{
    return tableView
  }
  @IBOutlet weak var coffeeTypeButton: CustomButton!
  
  
  @IBOutlet weak var restaurantTypeButton: CustomButton!
  
  var data: [District] = [District]()
  
  var selectedType = TypeSelected.restaurant
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupInterface()
    setupDatasource()
    tableView.delegate = self
    restaurantTypeButton.layer.borderWidth = 2.5
    coffeeTypeButton.layer.borderWidth = 0
  }
  
  @IBAction func cancelDistrict(_ sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func restaurantButton(_ sender: Any) {
    selectedType = TypeSelected.restaurant
    restaurantTypeButton.layer.borderWidth = 2.5
    coffeeTypeButton.layer.borderWidth = 0.0
  }

  @IBAction func coffeeButton(_ sender: Any) {
    selectedType = TypeSelected.coffee
    restaurantTypeButton.layer.borderWidth = 0.0
    coffeeTypeButton.layer.borderWidth = 2.5
  }
  
}

extension DistrictTableViewController: DataControllableProtocol, UITableViewDataSource, UITableViewDelegate{

  // MARK: - Table view data source
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView[indexPath] as! DistrictCell
    cell.configureCell(district: data[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.findLocationWithDistrict(district: data[indexPath.row], type: selectedType)
    dismiss(animated: true, completion: nil)
  }
  
}
