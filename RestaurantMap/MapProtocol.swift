//
//  MapProtocol.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

protocol MapProtocol {
  var map: GMSMapView { get set }
  var camera: GMSCameraPosition { get set }
}

extension MapProtocol where Self: UIViewController{
  
  func setupMapInterface() {
    map.isHidden = true
    map.isMyLocationEnabled = true
    map.setMinZoom(8.0, maxZoom: 15.0)
    map.settings.allowScrollGesturesDuringRotateOrZoom = false
    map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(map)
  }
  
  func getInToCurrentLocation() {
    if map.isHidden {
      map.camera = camera
      map.isHidden = false
    }else{
      map.animate(to: camera)
    }
  }

}
