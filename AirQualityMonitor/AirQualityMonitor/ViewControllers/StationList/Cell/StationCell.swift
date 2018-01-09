//
//  StationCell.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

    @IBOutlet weak var stationNameTitleLabel: UILabel!
    @IBOutlet weak var stationNameValueLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityValueLabel: UILabel!
    
    func configure(station: Station) {
        stationNameTitleLabel.text = "Station name:"
        stationNameValueLabel.text = station.stationName
        cityTitleLabel.text = "City:"
        cityValueLabel.text = station.city?.name
    }
}
