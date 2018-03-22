//
//  StationCell.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift

class StationCell: UITableViewCell {

    @IBOutlet weak var stationNameValueLabel: UILabel!
    
    func configure(station: Station) {
        stationNameValueLabel.text = station.stationName
    }
}
