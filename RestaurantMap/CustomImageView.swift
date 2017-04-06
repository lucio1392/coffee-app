//
//  CustomImageView.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = bounds.width / 2.0
  }
}
