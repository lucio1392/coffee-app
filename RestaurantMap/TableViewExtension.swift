//
//  TableViewExtension.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/6/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import Foundation

extension UITableView{
  public static var defaultCellIdentifier: String {
    return "Cell"
  }
  
  public func registerNib(nibName: String, cellIdentifier: String = defaultCellIdentifier, bundleIdentifier: String? = nil) {
    self.register(UINib(nibName: nibName,
                           bundle: bundleIdentifier != nil ? Bundle(identifier: bundleIdentifier!) : nil),
                     forCellReuseIdentifier: cellIdentifier)
  }
  
  public subscript(indexPath: IndexPath) -> UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: UITableView.defaultCellIdentifier, for: indexPath)
  }
  
  public subscript(indexPath: IndexPath, identifier: String) -> UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
  }
}

extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}
