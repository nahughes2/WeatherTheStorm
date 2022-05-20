//
//  String+DateConversion.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/20/22.
//

import Foundation

extension String {
    
    func stringToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: self)
    }
    
}
