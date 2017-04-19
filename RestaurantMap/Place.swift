//
//  Place.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation


public struct Place {
  
  private let BaseImageURL = "http://163.44.206.220:3000"
  
  var id_location: String
  var name: String
  var address: String
  var octime: String
  var rate: Double
  var lat: Double
  var long: Double
  var type: Int
  var district: String?
  var typeName: String
  var placeImageURL: URL
  
  var coordinate2D: CLLocationCoordinate2D{
    return CLLocationCoordinate2D(latitude: lat, longitude: long)
  }
  
  init(json: JSONObject) {
    self.id_location = json["id_location"] as! String
    self.name = json["name"] as! String
    self.address = json["address"] as! String
    self.octime = json["octime"] as! String
    self.rate = json["rate"] as! Double
    self.lat = json["lat"] as! Double
    self.long = json["long"] as! Double
    self.type = json["id_type"] as! Int
    self.typeName = json["type"] as! String
    let imageStringURL = json["image"] as! String
    self.placeImageURL = URL(string:BaseImageURL + imageStringURL)!
    self.district = json["district"] as? String
  }
  
}
