//
//  ViewController.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import UIKit

class CurrentTempViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var longitudelabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    // MARK: - Memebers
    var currentWeather: Weather?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLocation = getLocation()
        if let location = currentLocation {
            addLoadingView()
            async {
                do {
                    try currentWeather = await Networking().fetchCurrentData(location: location)
                    populateFields()
                } catch {
                    showErrorAlert(message: "Network failure")
                }
            }
        } else {
            showErrorAlert(message: "Location Unavailable")
        }
        removeLoadingView()
    }
    
    // MARK: -
    func populateFields() {
        tempLabel.text = currentWeather?.main?.temp?.description
        if let long = currentLocation?.longitude.description {
            longitudelabel.text = "Longitude: \(long)"
        }
        if let lat = currentLocation?.latitude.description {
            latitudeLabel.text = "Latitude: \(lat)"
        }
    }
}
