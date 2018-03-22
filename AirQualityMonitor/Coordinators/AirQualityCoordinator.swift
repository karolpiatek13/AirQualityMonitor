//
//  AirQualityCoordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class AirQualityCoordinator: Coordinator {
    
    var station: Station
    
    init(station: Station) {
        self.station = station
        super.init()
    }
}

extension AirQualityCoordinator: CoordinatorProtocol {
    
    func start() {
        let vc = AirQualityIndexViewController(viewModel: AirQualityViewModel(flowDelegate: self, station: station))
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func backToParent() {
        guard let parentCoordinator = parent as? AppCoordinator else { return }
        parentCoordinator.backToCoordinator()
    }
}
