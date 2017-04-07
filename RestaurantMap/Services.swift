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
  
  private lazy var configuration: URLSessionConfiguration = {
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = true
    configuration.timeoutIntervalForRequest = 20.0
    
    return configuration
  }()
  
  private lazy var session: URLSession = {
    
    let session = URLSession(configuration: self.configuration)
    
    return session
    
  }()
  
  fileprivate func request(urlRequest: URLRequest,
                           completion: @escaping Completion) -> URLSessionDataTask {
    
    return session.dataTask(with: urlRequest) { (data, response, error) in
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
    }
  }
  
  func requestPlace(params: JSONObject, from: RequestPlace, completionHandle: @escaping PlaceResultCompletion) -> URLSessionDataTask {
    
    var urlRequest: URLRequest!
    
    switch from {
    case .near: urlRequest = Router.searchNear(params).asURLRequest()
    case .district: urlRequest = Router.searchDistrict(params).asURLRequest()
    }
    
    return request(urlRequest: urlRequest) { (success, jsonObjects) in
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
