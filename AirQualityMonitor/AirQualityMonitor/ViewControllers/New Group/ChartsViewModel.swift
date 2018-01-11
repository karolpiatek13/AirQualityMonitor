//
//  ChartsViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation
import RxSwift

class ChartsViewModel: BaseTabViewModel {
    
    var chartValues = PublishSubject<[SensorDataRead]>()
    var displayMeasurement = PublishSubject<Measurement>()
    var displayDate: Observable<String> {
        return displayMeasurement.asObservable().map { $0.date ?? "" }
    }
    var displayValue: Observable<String> {
        return displayMeasurement.asObservable().map { $0.value }
    }
    var displayName: Observable<String> {
        return displayMeasurement.asObservable().map { $0.name }
    }
    
    func getData() {
        getStationSensors()
    }
    
    func fetchFirstChartData() {
        guard let measurement = measurements?.first else { return }
        fetchChartData(measurement: measurement)
    }
    
    func fetchChartData(measurement: Measurement) {
        provider.rx.request(.sensorData(id: measurement.sensorId))
            .asObservable()
            .map(SensorData.self)
            .subscribe { event in
                switch event {
                case .next(let sensorData):
                    guard let values = (sensorData.values?.filter { $0.value != nil }) else { return }
                    self.chartValues.onNext(values.reversed())
                    if let value = values.first?.value, let date = values.first?.date {
                        measurement.value = String(describing: value)
                        measurement.date = date
                    }
                    self.displayMeasurement.onNext(measurement)
                case .error:
                    print("error")
                case .completed:
                    print("completed")
                }
            }.disposed(by: bag)
    }
}
