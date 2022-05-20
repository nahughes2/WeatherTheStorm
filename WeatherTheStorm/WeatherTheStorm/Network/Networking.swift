//
//  Networking.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import Foundation

class Networking {
    
    func fetchCurrentData(location: Location) async throws -> Weather? {
        let URLwithQueries = buildURL(location: location, isForecast: false)
        
        guard let url = URL(string: URLwithQueries) else {
            // URL error
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(Weather.self, from: data)
            
            return result
        } catch {

            return nil
        }
    }
    
    func fetchForecastData(location: Location) async throws -> FullForecast? {
        let URLwithQueries = buildURL(location: location, isForecast: true)
        
        guard let url = URL(string: URLwithQueries) else {
            // URL error
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(FullForecast.self, from: data)
            
            return result
        } catch {

            return nil
        }
    }
    
    func buildURL(location: Location, isForecast: Bool) -> String {
        let lat = "lat=\(location.latitude)"
        let long = "&lon=\(location.longitude)"
        let units = "&units=imperial"
        let appid = "&appid=\(Constants.unsafelyStoredKey)"
        
        if isForecast {
            
            return Constants.forecastURL + lat + long + appid + units
        }
        
        return Constants.rawURL + lat + long + appid + units
    }
}
