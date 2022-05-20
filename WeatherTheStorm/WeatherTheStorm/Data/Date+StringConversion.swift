//
//  Date+StringConversion.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import Foundation

extension Date {

    func convertTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }

    func dateString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
        
    }
    
}
