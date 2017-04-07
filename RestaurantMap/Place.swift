//
//  Place.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation


public struct Place {
  var id: String
  var name: String
  var address: String
  var octime: String
  var rate: Double
  var lat: Double
  var long: Double
  var type: String
  var district: String?
  
  var coordinate2D: CLLocationCoordinate2D{
    return CLLocationCoordinate2D(latitude: lat, longitude: long)
  }
  
  init(json: JSONObject) {
    self.id = json["id"] as! String
    self.name = json["name"] as! String
    self.address = json["address"] as! String
    self.octime = json["octime"] as! String
    self.rate = json["rate"] as! Double
    self.lat = json["lat"] as! Double
    self.long = json["long"] as! Double
    self.type = json["type"] as! String
    self.district = json["district"] as? String
  }
  
}
