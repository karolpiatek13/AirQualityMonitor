//
//  SensorListCoordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class SensorListCoordinator: Coordinator {
    
    var station: Station
    
    init(station: Station) {
        self.station = station
        super.init()
    }
}

extension SensorListCoordinator: CoordinatorProtocol {
    
    func start() {
        let vc = SensorListViewController(viewModel: SensorListViewModel(flowDelegate: self, station: station))
        navigationController.setViewControllers([vc], animated: true)
    }
}
