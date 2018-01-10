//
//  AirQualityViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift

class AirQualityViewModel {
    
    var flowDelegate: CoordinatorProtocol
    var station: Station
    var stationName = Variable<String>("")
    var measurements: [Measurement]?
    var measurementsSection = PublishSubject<[RxDataSourcesSection<Measurement>]>()
    var lowestMeasurement = PublishSubject<Measurement>()
    var lastupDate: Observable<String> {
        return lowestMeasurement.asObservable().map { $0.date ?? "" }
    }
    var airStatus: Observable<IndexNameEnum> {
        return lowestMeasurement.asObservable().map { $0.indexLevelEnum ?? IndexNameEnum.noValue }
    }
    
    let provider = NetworkProvider<AirQualityService>()
    let bag = DisposeBag()
    
    init(flowDelegate: CoordinatorProtocol, station: Station) {
        self.flowDelegate = flowDelegate
        self.station = station
        self.stationName.value = station.stationName ?? ""
        getStationSensors()
    }
    
    func getStationSensors() {
        provider.rx.request(.stationSensors(id: station.id ?? -1))
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
        provider.rx.request(.stationData(id: station.id ?? -1))
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
                    guard var lowestMeas = measurements.first else { return }
                    for measurement in measurements {
                        guard let lowest = lowestMeas.indexLevelEnum?.rawValue,
                            let current = measurement.indexLevelEnum?.rawValue else { return }
                        if lowest > current {
                            lowestMeas = measurement
                        }
                    }
                    self.lowestMeasurement.onNext(lowestMeas)
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
            }.disposed(by: bag)
    }
    
    func getMeasurementList(sensors: [Sensor]) -> [Measurement] {
        return sensors.map { return Measurement(name: $0.param?.paramName ?? "", code: $0.param?.paramCode ?? "") }
    }
}
