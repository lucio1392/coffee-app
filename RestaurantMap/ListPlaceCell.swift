//
//  ListPlaceCell.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    print(place.placeImageURL)
    typeImageView.layer.cornerRadius = 5.0
    typeImageView.clipsToBounds = true
    typeImageView.kf.indicatorType = .activity
    typeImageView.kf.setImage(with: place.placeImageURL)
    nameLabel.text = place.name
    addressLabel.text = place.address
    openTimeLabel.text = "Open Time: \(place.octime)"
  }
}
