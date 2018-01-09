//
//  Coordinator.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

class Coordinator {
    
    var childCoordinators = [Coordinator]()
    let navigationViewController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationViewController = navigationController
    }
    
    func addChildCoordinator(childCoordinator: Coordinator...) {
        childCoordinator.forEach {
            childCoordinators.append($0)
        }
    }
    
    func removeChildCoordinator(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
