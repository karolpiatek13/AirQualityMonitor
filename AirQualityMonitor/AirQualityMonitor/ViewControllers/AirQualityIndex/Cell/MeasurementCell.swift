//
//  MeasurementCell.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class MeasurementCell: UICollectionViewCell {

    @IBOutlet weak var indexCodeLabel: UILabel!
    @IBOutlet weak var indexValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(measurement: Measurement) {
        indexCodeLabel.text = measurement.code
        indexCodeLabel.textColor = measurement.indexLevelEnum?.textColor
        indexValueLabel.text = measurement.indexLevelEnum?.textValue
        indexValueLabel.textColor = measurement.indexLevelEnum?.textColor
        nameLabel.text = measurement.name
        nameLabel.textColor = measurement.indexLevelEnum?.textColor
        backgroundColor = measurement.indexLevelEnum?.colorValue
    }
}
