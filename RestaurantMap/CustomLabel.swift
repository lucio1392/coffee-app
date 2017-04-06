//
//  CustomLabel.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/5/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 5.0
    clipsToBounds = true
  }

}
