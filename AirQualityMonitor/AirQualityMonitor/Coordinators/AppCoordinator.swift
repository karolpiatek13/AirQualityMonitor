//
//  AppCoordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

protocol AppCoordinatorProtocol {
    func showMainTabBar(station: Station)
}

final class AppCoordinator: Coordinator {
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        presentStationList()
    }
    
    private func presentStationList() {
        let viewModel = StationListViewModel(delegate: self)
        let viewController = StationListViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    
    func showMainTabBar(station: Station) {
        let coordinators: [Coordinator & CoordinatorProtocol] = [
            AirQualityCoordinator(station: station),
            SensorListCoordinator(station: station),
            StationDetailsCoordinator(station: station)
        ]
        
        showInTabBarViewController(coordinators: coordinators)
    }
    
    private func showInTabBarViewController(coordinators: [Coordinator & CoordinatorProtocol]) {
        coordinators.forEach {
            $0.start()
            self.childCoordinators.append($0)
        }
        let viewController = TabBarViewController(controllers: coordinators.map({ $0.navigationController }))
        navigationController.pushViewController(viewController, animated: true)
    }
}
