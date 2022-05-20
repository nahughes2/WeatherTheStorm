//
//  ForecastCell.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/17/22.
//

import Foundation
import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var onReuse: () -> Void = {}

      override func prepareForReuse() {
          super.prepareForReuse()
          onReuse()
          // BUG
          //iconImageView.image = nil
      }
    
}
