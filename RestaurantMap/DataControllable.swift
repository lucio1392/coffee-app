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
    
    data = [District(name: "Quận Hà Đông"),District(name: "Quận Hai Bà Trưng"),District(name: "Quận Hoàn Kiếm"),District(name: "Quận Ba Đình"),District(name: "Quận Thanh Xuân"),District(name: "Quận Đống Đa"),District(name: "Quận Cầu Giấy"),District(name: "Quận Tây Hồ"),District(name: "Quận Hoàng Mai"),District(name: "Quận Nam Từ Liêm"),District(name: "Quận Bắc Từ Liêm"),District(name: "Quận Long Biên"),District(name: "Gia Lâm")]
    dataViewable.reloadData()
  }
  
}
