//
//  Router.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/5/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

typealias JSONObject = [String: Any]

enum RequestMethod{
  case get
  case post
  case put
  case delete
  
  var method: String{
    switch self {
    case .get: return "GET"
    case .post: return "POST"
    case .put: return "PUT"
    case .delete: return "DELETE"
    }
  }
}

enum Router {
  
  case searchNear(JSONObject)
  case searchDistrict(JSONObject)
  
  fileprivate var method: String{
    switch self {
    case .searchNear, .searchDistrict: return RequestMethod.post.method
    }
  }
  
  func asURLRequest() -> URLRequest{
    
    let url: URL = {
      let relativePath: String?
      
      switch self{
      case .searchNear: relativePath = "location"
      case .searchDistrict: relativePath = "district"
      }
      var url = URL(string: NetworkService.BaseURL)!
      if let relativePath = relativePath{
        url.appendPathComponent(relativePath)
      }
      
      return url
    }()
    
    let parameters: JSONObject? = {
      switch self{
      case .searchNear(let param), .searchDistrict(let param): return param
      }
    }()
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    if let parameter = parameters {
      var stringBody = ""
      for (key,value) in parameter {
        stringBody = stringBody.appending(key)
        stringBody = stringBody.appending("=")
        stringBody = stringBody.appending(String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        stringBody = stringBody.appending("&")
      }
      
      let dataBody = stringBody.data(using: .utf8)
      request.httpBody = dataBody
    }
    
    return request
    
  }
  
}
