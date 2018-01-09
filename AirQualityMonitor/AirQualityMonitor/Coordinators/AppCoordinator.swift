//
//  AppCoordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

protocol AppCoordinatorProtocol {
    
}

class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    
    func start() {
        navigationViewController.setNavigationBarHidden(true, animated: false)
        presentStationList()
    }
    
    private func presentStationList() {
        let viewModel = StationListViewModel(delegate: self)
        let viewController = StationListViewController(viewModel: viewModel)
        navigationViewController.setViewControllers([viewController], animated: false)
    }
}
