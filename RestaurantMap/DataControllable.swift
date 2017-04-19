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
    
    data = [District(name: "Quận Hà Đông", id: 1),District(name: "Quận Hai Bà Trưng", id: 2),District(name: "Quận Hoàn Kiếm", id: 3),District(name: "Quận Ba Đình", id: 4),District(name: "Quận Thanh Xuân", id: 5),District(name: "Quận Đống Đa", id: 6),District(name: "Quận Cầu Giấy", id: 7),District(name: "Quận Tây Hồ", id: 8),District(name: "Gia Lâm", id: 9),District(name: "Quận Hoàng Mai", id: 10),District(name: "Quận Nam Từ Liêm", id: 11),District(name: "Quận Bắc Từ Liêm", id: 12),District(name: "Quận Long Biên", id: 13)]
    dataViewable.reloadData()
  }
  
}
