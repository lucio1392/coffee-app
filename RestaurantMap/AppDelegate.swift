//
//  AppDelegate.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var pullyVC: PulleyViewController!
  var mapVC: MapVC!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    
    GMSServices.provideAPIKey(APIKey.GoogleMapAPIKey)
    setupInitView()
    return true
  }
  
  func setupInitView() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    mapVC = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
    
    let listPlaceVC = storyboard.instantiateViewController(withIdentifier: "ListPlaceVC") as! ListPlaceVC
    
    pullyVC = PulleyViewController(contentViewController: mapVC, drawerViewController: listPlaceVC)
    
    window?.rootViewController = pullyVC
    window?.makeKeyAndVisible()
    
    
  }

}

