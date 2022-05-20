//
//  Models.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import Foundation

struct FullForecast: Decodable {
    var list: [Weather]
}

struct Weather: Decodable {
    var weather: [CurrentWeather]
    var main: Temp?
    var dt_txt: String?
}

struct CurrentWeather: Decodable {
    var icon: String?
}

struct Temp: Decodable {
    var temp: Double?
}

struct Location {
    var longitude: Double
    var latitude: Double
}
