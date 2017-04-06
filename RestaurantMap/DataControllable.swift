//
//  DataControllable.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

public protocol DataControllableProtocol: class {
  var dataViewable: DataViewableProtocol { get }
  var data: [District] { get set }
  var cellNibName: String { get }
  var cellIdentifier: String { get }
  var cellBundleIdentifier: String { get }
}

public extension DataControllableProtocol where Self: UIViewController{
  
  var cellIdentifier: String{
    return "Cell"
  }
  
  var cellBundleIdentifier: String{
    return "com.vtsolution.RestaurantMap"
  }
  
  public func setupInterface(){
    dataViewable.registerNib(nibName: cellNibName, cellIdentifier: cellIdentifier, bundleIdentifier: cellBundleIdentifier)
  }
  
  public func setupDatasource() {
    data = [District(name: "hai ba trung"),District(name: "hoan kiem")]
    dataViewable.reloadData()
  }
  
}
