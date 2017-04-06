//
//  DistrictCell.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class DistrictCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configureCell(district: District) {
    textLabel?.text = district.name
  }
  
}
