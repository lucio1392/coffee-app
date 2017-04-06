//
//  DataViewableProtocol.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

public protocol DataViewableProtocol {
  func reloadData()
  func registerNib(nibName: String, cellIdentifier: String, bundleIdentifier: String?)
}

extension UITableView: DataViewableProtocol{}
