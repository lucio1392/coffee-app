//
//  Constants.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

struct APIKey {
  static let GoogleMapAPIKey = "AIzaSyDRERmWZhFOXn_k7k9QXWgss36gJHu6gd8"
}

struct MapConstant {
  static let ZoomValue = Float(13.0)
}

struct NetworkService {
  static let BaseURL = "http://163.44.206.220:3000/find/"
}

struct FindType {
  static let RestaurantType = 1
  static let CoffeeType = 2
}

enum TypeSelected {
  case restaurant
  case coffee
  
  var describe: Int{
    switch self {
    case .restaurant: return 1
    case .coffee: return 2
    }
  }
}

struct CellIdentifier {
  static let District = "DistrictCell"
}
