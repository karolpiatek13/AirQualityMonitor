//
//  BaseViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift

class BaseTabViewModel {
    
    var flowDelegate: CoordinatorProtocol
    var station: Station
    var measurements: [Measurement]?
    var measurementsSection = BehaviorSubject<[RxDataSourcesSection<Measurement>]>(value: [])
    
    let bag = DisposeBag()
    let provider = NetworkProvider<AirQualityService>()
    
    init(flowDelegate: CoordinatorProtocol, station: Station) {
        self.flowDelegate = flowDelegate
        self.station = station
        getStationSensors()
    }

    func getStationSensors() {
        guard let id = station.id else { return }
        provider.rx.request(.stationSensors(id: id))
            .asObservable()
            .share()
            .map([Sensor].self)
            .subscribe { event in
                switch event {
                case .next(let sensors):
                    self.measurements = self.getMeasurementList(sensors: sensors)
                    self.getAirQualityIndex()
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
            }.disposed(by: bag)
    }
    
    func getAirQualityIndex() {
        guard let id = station.id else { return }
        provider.rx.request(.stationData(id: id))
            .asObservable()
            .share()
            .map(AirQualityIndex.self)
            .subscribe { event in
                switch event {
                case .next(let airQualityIndex):
                    guard let measurements = self.measurements else { return }
                    let newMeasurements = airQualityIndex.assignValues(measurements: measurements)
                    self.measurements = newMeasurements
                    self.measurementsSection.onNext([RxDataSourcesSection(header: "", items: newMeasurements)])
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
            }.disposed(by: bag)
    }
    
    func getMeasurementList(sensors: [Sensor]) -> [Measurement] {
        return sensors.map { return Measurement(name: $0.param?.paramName ?? "", code: $0.param?.paramCode ?? "", sensorId: $0.id ?? -1) }
    }
}
