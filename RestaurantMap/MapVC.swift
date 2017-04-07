//
//  ViewController.swift
//  RestaurantMap
//
//  Created by Vinh The on 4/3/17.
//  Copyright © 2017 Vinh The. All rights reserved.
//

import UIKit

protocol MapVCProtocol: class {
  func placesResult(places: [Place])
}

class MapVC: UIViewController, ManagerLocationProtocol {
  
  // MARK: - Properties
  
  weak var delegate: MapVCProtocol?
  
  @IBOutlet weak var getCurrentLocationButton: UIButton!
  @IBOutlet weak var loadingLabel: UILabel!
  @IBOutlet weak var radiusLabel: CustomLabel!
  @IBOutlet weak var typeView: UIView!
  @IBOutlet weak var restaurantTypeButton: CustomButton!
  @IBOutlet weak var coffeeTypeButton: CustomButton!
  @IBOutlet weak var districtButton: UIButton!
  
  lazy var destinationMarker: GMSMarker = {
    let destinationMarker = GMSMarker()
    destinationMarker.icon = #imageLiteral(resourceName: "Destination Marker")
    destinationMarker.appearAnimation = .pop
    destinationMarker.map = self.map
    return destinationMarker
  }()
  
  lazy var managerLocation: CLLocationManager = CLLocationManager()
  lazy var currentLocation: CLLocation = CLLocation()
  lazy var locationForFindLocation: CLLocation = CLLocation()
  lazy var map: GMSMapView = GMSMapView(frame: self.view.bounds)
  lazy var camera: GMSCameraPosition = GMSCameraPosition()
  var customMarkers = [GMSMarker]()
  var places = [Place]()
  var selectedType = TypeSelected.restaurant
  var isFindDistrict: Bool = false
		
  //MARK: - Functions
  
  @IBAction func restaurantTypeAction(_ sender: UIButton) {
    selectedType = TypeSelected.restaurant
    restaurantTypeButton.layer.borderWidth = 2.5
    coffeeTypeButton.layer.borderWidth = 0.0
    findNearLocation {
      self.delegate?.placesResult(places: self.places)
    }
  }
  
  @IBAction func coffeeTypeAction(_ sender: UIButton) {
    selectedType = TypeSelected.coffee
    restaurantTypeButton.layer.borderWidth = 0.0
    coffeeTypeButton.layer.borderWidth = 2.5
    findNearLocation {
      self.delegate?.placesResult(places: self.places)
    }
  }
  
  @IBAction func findDistrictAction(_ sender: UIButton) {
    let districtNav = storyboard?.instantiateViewController(withIdentifier: "DistrictNavigationVC") as! UINavigationController
    let district = districtNav.viewControllers.first! as! DistrictTableViewController
    district.delegate = self
    present(districtNav, animated: true, completion: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initilizeManagerLocation()
    setupMapInterface()
    orderSubViews()
    configurateInitSubViews()
    map.delegate = self
  }
  
  func configurateInitSubViews() {
    loadingLabel.isHidden = true
    restaurantTypeButton.layer.borderWidth = 2.5
    coffeeTypeButton.layer.borderWidth = 0
    districtButton.layer.cornerRadius = districtButton.bounds.width / 2.0
  }
  
  func orderSubViews() {
    view.bringSubview(toFront: getCurrentLocationButton)
    view.bringSubview(toFront: loadingLabel)
    view.bringSubview(toFront: radiusLabel)
    view.bringSubview(toFront: typeView)
    view.bringSubview(toFront: districtButton)
  }
  
  @IBAction func getCurrentLocationAction(_ sender: UIButton) {
    camera = GMSCameraPosition.camera(withTarget: currentLocation.coordinate, zoom: MapConstant.ZoomValue)
    getInToCurrentLocation()
  }
  
  func updateMarkerPosition(currentLocation: CLLocationCoordinate2D) {
    CATransaction.begin()
    destinationMarker.position = currentLocation
    CATransaction.commit()
  }
  
  func findNearLocation(completionHandle: @escaping ()->()) {
    var type: String!
    
    switch selectedType {
    case .restaurant: type = FindType.RestaurantType
    case .coffee: type = FindType.CoffeeType
    }
    
    let params: JSONObject = ["lat": locationForFindLocation.coordinate.latitude,
                              "long": locationForFindLocation.coordinate.longitude,
                              "r": map.getRadius(),
                              "type": type]
    
    Services.shared.requestPlace(params: params, from: .near) { (placesResult) in
      self.loadingLabel.isHidden = true
      self.typeView.isHidden = false
      print(placesResult)
      self.places = placesResult
      self.drawResultMarkers(places: placesResult, map: self.map)
      completionHandle()
    }
  }

}

  //MARK: - MapView & LocationManagerDelegate
extension MapVC: MapProtocol{
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let newLocation = locations.last else { print("can not get location")
      return
    }
  
    currentLocation = newLocation
    
    camera = GMSCameraPosition.camera(withTarget: newLocation.coordinate, zoom: MapConstant.ZoomValue)
    
    getInToCurrentLocation()
    destinationMarker.position = currentLocation.coordinate
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    switch status {
    case .denied: print("User denied authorization")
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse: print("Location status is OK")
    case .notDetermined: print("Location can not determined")
      map.isHidden = false
    case .restricted: print("Location is restricted")
    }
    
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("\(error.localizedDescription)")
  }
  
}

  //MARK: - GMSMapViewDelegate

extension MapVC: GMSMapViewDelegate{

  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    loadingLabel.isHidden = false
    typeView.isHidden = true
  }
  
  func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
    if !isFindDistrict {
      updateMarkerPosition(currentLocation: position.target)
    }
    self.radiusLabel.text = "Radius: \(mapView.getRadius()) m"
  }
  
  
  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    
    if !isFindDistrict {
      locationForFindLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
      
      findNearLocation {
        self.delegate?.placesResult(places: self.places)
      }
    }else{
      self.loadingLabel.isHidden = true
      self.typeView.isHidden = false
      isFindDistrict = false
    }
    
  }
  
  // MARK: - Marker Delegate
  
  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    mapView.selectedMarker = marker
    return true
  }
  
  func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    let infoView = Bundle.main.loadNibNamed("InfoWindow", owner: self.view, options: nil)!.first as! InfoWindow
    
    infoView.configuratePlace(place: places[getIndexOfPlace(from: marker)])
    
    return infoView
  }
  
  func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    let placeOnMarker = places[getIndexOfPlace(from: marker)]
    
    let detailPlace = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
    detailPlace.place = placeOnMarker
    
    present(detailPlace, animated: true, completion: nil)
    
  }
  
  // MARK: - Marker Funcs ----- Can refactor
  func drawResultMarkers(places: [Place], map: GMSMapView) {
    
    clearCurrentCustomerMarkers()
    
    var markerImage: UIImage!
    
    for place in places {
      let marker = GMSMarker(position: place.coordinate2D)
      marker.appearAnimation = .pop
      marker.title = place.name
      
      if place.type == FindType.RestaurantType {
        markerImage = #imageLiteral(resourceName: "Restaurant Marker")
      }else{
        markerImage = #imageLiteral(resourceName: "Coffee Marker")
      }
      marker.icon = markerImage
      
      marker.map = map
      
      customMarkers.append(marker)
    }

  }
  
  func clearCurrentCustomerMarkers() {
    for customMarker in customMarkers{
      customMarker.map = nil
    }
    
    customMarkers.removeAll()
  }
  
  func getIndexOfPlace(from marker: GMSMarker) -> Int {
    var result = 0

    for i in 0 ..< customMarkers.count {
      let customMarker = customMarkers[i]
      if customMarker.position.latitude == marker.position.latitude &&
        customMarker.position.longitude == marker.position.longitude{
        result = i
      }
    }
    
    return result
  }
  
}

extension MapVC: DistrictTableViewControllerProtocol{
  internal func findLocationWithDistrict(district: District, type: TypeSelected) {
    
    let params : JSONObject = ["district": district.name,
                  "type": type]
    
    Services.shared.requestPlace(params: params, from: .district) { (placesResult) in
      
      if placesResult.count > 0 {
        let place = placesResult[0]
        self.isFindDistrict = true
        self.selectedType = type
        self.camera = GMSCameraPosition.camera(withTarget: place.coordinate2D, zoom: MapConstant.ZoomValue)
        
        self.getInToCurrentLocation()
        self.updateMarkerPosition(currentLocation: place.coordinate2D)
        self.drawResultMarkers(places: placesResult, map: self.map)
        self.delegate?.placesResult(places: placesResult)
      }
      
    }
    
  }
}

























