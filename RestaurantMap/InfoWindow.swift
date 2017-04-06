//
//  InfoWindow.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/5/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class InfoWindow: UIView {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var openTimeLabel: UILabel!
  @IBOutlet weak var typeImageView: UIImageView!

  func configuratePlace(place: Place) {
    typeImageView.layer.cornerRadius = typeImageView.bounds.width / 2.0
    
    switch place.type {
    case FindType.RestaurantType:
      typeImageView.image = #imageLiteral(resourceName: "RestaurantButton")
    case FindType.CoffeeType:
      typeImageView.image = #imageLiteral(resourceName: "CoffeeButton")
    default:
      print("No Type")
    }
    
    openTimeLabel.text = place.octime
    nameLabel.text = place.name
    addressLabel.text = place.address
  }
}
