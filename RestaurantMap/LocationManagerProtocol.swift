//
//  LocationManager.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation
import UIKit

public protocol ManagerLocationProtocol: CLLocationManagerDelegate {
  var managerLocation: CLLocationManager { get set }
  var currentLocation: CLLocation { get set }
}

extension ManagerLocationProtocol where Self: UIViewController{
  
  public func initilizeManagerLocation(){
    managerLocation.desiredAccuracy = kCLLocationAccuracyBest
    managerLocation.requestAlwaysAuthorization()
    managerLocation.distanceFilter = 50
    managerLocation.startUpdatingLocation()
    managerLocation.delegate = self
  }
  
}
