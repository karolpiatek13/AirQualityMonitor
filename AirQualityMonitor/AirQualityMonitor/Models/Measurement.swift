//
//  Measurement.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

class Measurement {
    var name: String
    var code: String
    var date: String?
    var indexLevelEnum: IndexNameEnum?
    
    init(name:String, code: String) {
        self.name = name
        self.code = code
    }
}
