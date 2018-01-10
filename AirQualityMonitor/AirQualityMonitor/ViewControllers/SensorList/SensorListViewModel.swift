//
//  SensorListViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

class SensorListViewModel {
    
    var flowDelegate: CoordinatorProtocol
    var station: Station
    
    init(flowDelegate: CoordinatorProtocol, station: Station) {
        self.flowDelegate = flowDelegate
        self.station = station
    }
}
