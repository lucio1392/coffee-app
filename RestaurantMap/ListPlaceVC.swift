//
//  ListPlaceVCV.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ListPlaceVC: UIViewController, DataControllableProtocol {
  
  public var cellNibName: String = "ListPlaceCell"

  public var data: [District] = [District]()

  public var dataViewable: DataViewableProtocol{
    return tableView
  }
  
  var places = [Place]()

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
      appDelegate.mapVC.delegate = self
        // Do any additional setup after loading the view.
      setupInterface()
    }
}

extension ListPlaceVC: MapVCProtocol{
  func placesResult(places: [Place]) {
    self.places = places
    tableView.reloadData()
  }
}

extension ListPlaceVC: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return places.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView[indexPath] as! ListPlaceCell
    cell.configureCell(place: places[indexPath.row])
    return cell
  }
}

extension ListPlaceVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85.0
  }
}

extension ListPlaceVC: PulleyDrawerViewControllerDelegate{
  public func supportedDrawerPositions() -> [PulleyPosition] {
    return PulleyPosition.all
  }

  public func partialRevealDrawerHeight() -> CGFloat {
    return view.bounds.height / 2.5
  }

  func collapsedDrawerHeight() -> CGFloat {
    return 20.0
  }
}
