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
    var stations = PublishSubject<[Station]>()
    var stationsSection = PublishSubject<[RxDataSourcesSection<Station>]>()
    var stationsShownSection = PublishSubject<[RxDataSourcesSection<Station>]>()
    let provider = NetworkProvider<AirQualityService>()
    let bag = DisposeBag()
    
    init(delegate: AppCoordinatorProtocol) {
        self.delegate = delegate
        fetchStations()
    }
    
    func fetchStations() {
        provider.rx.request(.allStations)
            .asObservable()
            .map([Station].self)
            .subscribe { event in
                switch event {
                case .next(let stations):
                    self.stations.onNext(stations)
                    let section = [RxDataSourcesSection(header: "", items: stations)]
                    self.stationsSection.onNext(section)
                    self.stationsShownSection.onNext(section)
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
