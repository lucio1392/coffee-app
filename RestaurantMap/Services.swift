//
//  Services.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/5/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation
import UIKit

typealias Completion = (Bool, [JSONObject]?) -> ()
typealias PlaceResultCompletion = ([Place]) -> ()

enum RequestPlace {
  case near
  case district
}

class Services {
  
  static let shared = Services()
  
  private init(){}
  
  private var session = URLSession(configuration: .default)
  
  fileprivate func request(urlRequest: URLRequest,
                           completion: @escaping Completion) {
    
    session.dataTask(with: urlRequest) { (data, response, error) in
      if let _ = error{
        completion(false, nil)
      }else{
        
        guard let data = data, let responseHTTP = response as? HTTPURLResponse, responseHTTP.statusCode == 200 else { return }

        do{
          let jsons = try JSONSerialization.jsonObject(with: data, options: []) as? [JSONObject]
          
          completion(true, jsons)
          
        }catch _ as NSError{
          completion(false, nil)
        }
        
      }
    }.resume()
  }
  
  func requestPlace(params: JSONObject, from: RequestPlace, completionHandle: @escaping PlaceResultCompletion) {
    
    var urlRequest: URLRequest!
    
    switch from {
    case .near: urlRequest = Router.searchNear(params).asURLRequest()
    case .district: urlRequest = Router.searchDistrict(params).asURLRequest()
    }
    
    request(urlRequest: urlRequest) { (success, jsonObjects) in
      if success{
        var places = [Place]()
        
        for json in jsonObjects!{
          let place = Place(json: json)
          
          places.append(place)
        }
        
        DispatchQueue.main.async {
            completionHandle(places)
        }

      }
    }
    
  }
  
}
