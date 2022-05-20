//
//  ForecastViewController.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import UIKit

class ForecastViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var forecastTable: UITableView!
    
    // MARK: - Memebers
    var forecastingList: FullForecast?
    var loader = ImageLoader()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        forecastTable.delegate = self
        forecastTable.dataSource = self
        
        currentLocation = getLocation()
        if let location = currentLocation {
            addLoadingView()
            async {
                do {
                    try forecastingList = await Networking().fetchForecastData(location: location)
                    self.forecastTable.reloadData()
                } catch {
                    showErrorAlert(message: "Network failure")
                }
            }
        } else {
                showErrorAlert(message: "Location Unavailable")
        }
        removeLoadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        forecastTable.reloadData()
    }
    
    // MARK: - Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecastingList = self.forecastingList {
            return forecastingList.list.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCellType", for: indexPath) as? ForecastCell
        if let forecastingList = self.forecastingList?.list {
            cell?.tempLabel.text = forecastingList[indexPath.row].main?.temp?.description
            setDateTime(weather: forecastingList[indexPath.row], cell: cell)
            
            if let iconString = forecastingList[indexPath.row].weather[0].icon {
                let imageURL = Constants.imageURL + iconString + "@2x.png"
                
                guard let url = URL(string: imageURL) else {
                    if let forecastCell = cell {
                        return forecastCell
                    }
                    
                    return UITableViewCell()
                }
                
                let token = loader.loadImage(url) { result in
                    do {
                        let image = try result.get()
                        DispatchQueue.main.async {
                            if let imageView = cell?.imageView {
                                imageView.image = image
                                cell?.setNeedsLayout()
                            }
                        }
                    } catch {
                        // failed to fetch image
                        // hide view? display default image?
                        print(error)
                    }
                }

                cell?.onReuse = {
                    if let token = token {
                        self.loader.cancelLoad(token)
                    }
                }
            }
            
            if let forecastCell = cell {
                return forecastCell
            }
        
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do nothing
    }
    
    // MARK: -
    func setDateTime(weather: Weather, cell: ForecastCell?) {
        let date = weather.dt_txt?.stringToDate()
        if let date = date {
            cell?.timeLabel.text = date.convertTime()
            cell?.dateLabel.text = date.dateString()
        }
    }
    
}
