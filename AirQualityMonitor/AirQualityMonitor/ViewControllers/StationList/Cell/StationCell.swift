//
//  StationCell.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift

class StationCell: UITableViewCell {

    @IBOutlet weak var stationNameTitleLabel: UILabel!
    @IBOutlet weak var stationNameValueLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityValueLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    
    var bag = DisposeBag()
    
    func configure(station: Station) {
        stationNameTitleLabel.text = "Station name:"
        stationNameValueLabel.text = station.stationName
        cityTitleLabel.text = "City:"
        cityValueLabel.text = station.city?.name
    }
}
