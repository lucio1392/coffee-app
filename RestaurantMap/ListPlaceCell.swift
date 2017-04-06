//
//  ListPlaceCell.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class ListPlaceCell: UITableViewCell {
  
  @IBOutlet weak var typeImageView: CustomImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var addressLabel: UILabel!
  
  @IBOutlet weak var openTimeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configureCell(place: Place) {
    switch place.type {
    case FindType.RestaurantType: typeImageView.image = #imageLiteral(resourceName: "RestaurantDetail")
    case FindType.CoffeeType: typeImageView.image = #imageLiteral(resourceName: "CoffeeDetail")
    default:
      print("Hi")
    }
    
    nameLabel.text = place.name
    addressLabel.text = place.address
    openTimeLabel.text = "Open Time: \(place.octime)"
  }
}
