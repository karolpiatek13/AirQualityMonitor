//
//  StationListViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Moya
import RxSwift

class StationListViewModel {
    
    var delegate: AppCoordinatorProtocol
    let provider = NetworkProvider<AirQualityService>()
    let bag = DisposeBag()
    
    init(delegate: AppCoordinatorProtocol) {
        self.delegate = delegate
        fetchSensor()
    }
    
    func fetchStations() {
        provider.rx.request(.allStations)
            .asObservable()
            .map([Station].self)
            .subscribe { event in
                switch event {
                case .next:
                    print("next")
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
        }.disposed(by: bag)
    }
    
    func fetchSensor() {
        provider.rx.request(.stationSensors(id: 14))
            .asObservable()
            .map([Sensor].self)
            .subscribe { event in
                switch event {
                case .next:
                    print("next")
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
        }.disposed(by: bag)
    }
}
