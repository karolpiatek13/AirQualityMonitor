//
//  StationListViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

class StationListViewModel {
    
    var delegate: AppCoordinatorProtocol
    
    init(delegate: AppCoordinatorProtocol) {
        self.delegate = delegate
    }
}
