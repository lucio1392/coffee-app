//
//  DetailVC.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
  
  var place: Place?
  
  @IBOutlet weak var typeImageView: CustomImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var openTimeLabel: UILabel!
  
  @IBOutlet weak var districtLabel: UILabel!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    configurateDetailPlace()
  }
  
  func configurateDetailPlace(){
    
    guard let place = place else { return }
    
    switch place.type {
    case FindType.RestaurantType: typeImageView.image = #imageLiteral(resourceName: "RestaurantDetail")
    case FindType.CoffeeType: typeImageView.image = #imageLiteral(resourceName: "CoffeeDetail")
    default:
      print("No Type")
    }
    
    nameLabel.text = place.name
    addressLabel.text = place.address
    openTimeLabel.text = "Open time: \(place.octime)"
    districtLabel.text = place.district
    rateLabel.text = "\(place.rate) / 10"
    typeLabel.text = place.type.uppercased()
  }
  
  @IBAction func doneAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}
