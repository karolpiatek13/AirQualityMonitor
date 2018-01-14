//
//  StationDetailsViewModel.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift
import MapKit

class StationDetailsViewModel {
    
    var flowDelegate: CoordinatorProtocol
    var station = BehaviorSubject<Station>(value: Station())
    var stationName: Observable<String> {
        return station.asObservable().map { $0.stationName ?? "Brak danych" }
    }
    var stationAddress: Observable<String> {
        return station.asObservable().map {
            guard let street = $0.addressStreet, let city = $0.city?.name else {
                return $0.city?.name ?? "Brak Danych"
            }
            return street + ", " + city
        }
    }
    
    init(flowDelegate: CoordinatorProtocol, station: Station) {
        self.flowDelegate = flowDelegate
        self.station.onNext(station)
    }
}
