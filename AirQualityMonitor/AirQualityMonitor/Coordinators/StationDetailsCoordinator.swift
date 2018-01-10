//
//  StationDetailsCoordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class StationDetailsCoordinator: Coordinator {
    
    var station: Station
    
    init(station: Station) {
        self.station = station
        super.init()
    }
}

extension StationDetailsCoordinator: CoordinatorProtocol {
    
    func start() {
        let vc = StationDetailsViewController(viewModel: StationDetailsViewModel(flowDelegate: self,station: station))
        navigationController.setViewControllers([vc], animated: true)
    }
}
