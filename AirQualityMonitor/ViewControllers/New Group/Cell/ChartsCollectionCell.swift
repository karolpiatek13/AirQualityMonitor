//
//  ChartsCollectionCell.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class ChartsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    
    func configure(measurement: Measurement, isSelected: Bool) {
        codeLabel.text = measurement.code
        self.backgroundColor = isSelected ? .white : .clear
    }
}
