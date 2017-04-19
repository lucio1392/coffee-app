//
//  InfoWindow.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/5/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit
import Kingfisher

class InfoWindow: UIView {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var openTimeLabel: UILabel!
  @IBOutlet weak var typeImageView: UIImageView!

  func configuratePlace(place: Place) {
    typeImageView.layer.cornerRadius = 8.0
    typeImageView.clipsToBounds = true
    
    typeImageView.kf.indicatorType = .activity
    typeImageView.kf.setImage(with: place.placeImageURL)
    
    openTimeLabel.text = place.octime
    nameLabel.text = place.name
    addressLabel.text = place.address
  }
}
