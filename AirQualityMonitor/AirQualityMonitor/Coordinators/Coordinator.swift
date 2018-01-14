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
    func backToParent()
}

class Coordinator {
    
    var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
