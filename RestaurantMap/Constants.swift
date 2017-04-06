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
  static let BaseURL = "http://localhost:3000/find/"
}

struct FindType {
  static let RestaurantType = "restaurant"
  static let CoffeeType = "coffee"
}

enum TypeSelected {
  case restaurant
  case coffee
}

struct CellIdentifier {
  static let District = "DistrictCell"
}
