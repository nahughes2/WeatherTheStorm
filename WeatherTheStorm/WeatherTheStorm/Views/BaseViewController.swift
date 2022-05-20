//
//  BaseViewController.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import CoreLocation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Memebers
    var loadingView = UIView()
    var alertController = UIAlertController()
    var locationManager = CLLocationManager()
    var currentLocation: Location?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        self.loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.loadingView.backgroundColor = .white
    }
    
    // MARK: - View Management
    func addLoadingView() {
        self.view.addSubview(self.loadingView)
    }
    
    func removeLoadingView() {
        self.loadingView.removeFromSuperview()
    }
    
    func showErrorAlert(message: String) {
        alertController = UIAlertController(title: "Are error has occured", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {})
    }
    
    // MARK: -
    func getLocation() -> Location? {
        locationManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways) {
            currentLocation = locationManager.location
        }
        
        if let _ = currentLocation {
            
            return Location(longitude: currentLocation.coordinate.longitude, latitude: currentLocation.coordinate.latitude)
        }
        
        return nil
    }
}
