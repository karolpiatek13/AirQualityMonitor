//
//  TabBarViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private typealias TabData = (imageInactive: UIImage, imageActive: UIImage)
    
    convenience init(controllers: [UIViewController]) {
        self.init()
        setupTabs(controllers: controllers)
        delegate = self
    }
    
    private func setupTabs(controllers: [UIViewController]) {
        viewControllers = controllers
        guard let tabControllers = viewControllers else { return }
        
        let tabImages: [TabData] = [
            (imageInactive: #imageLiteral(resourceName: "airQuality"), imageActive: #imageLiteral(resourceName: "airQuality")),
            (imageInactive: #imageLiteral(resourceName: "list"), imageActive: #imageLiteral(resourceName: "list")),
            (imageInactive: #imageLiteral(resourceName: "details"), imageActive: #imageLiteral(resourceName: "details"))
        ]
        
        controllers.enumerated().forEach { (arg) in
            let (index, controller) = arg
            controller.tabBarItem = UITabBarItem(title: nil, image: tabImages[index].imageInactive, selectedImage: tabImages[index].imageActive)
        }
        
        tabImages.enumerated().forEach { index, value in
            let controller = tabControllers[index]
            
            controller.tabBarItem = UITabBarItem(title: nil, image: value.imageInactive, selectedImage: value.imageActive)
            controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 100.0)
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {}
