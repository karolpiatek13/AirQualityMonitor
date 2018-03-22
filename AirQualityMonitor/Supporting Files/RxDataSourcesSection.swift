//
//  RxDataSourcesSection.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxDataSources

struct RxDataSourcesSection<T> {
    var header: String
    var items: [T]
}

extension RxDataSourcesSection: SectionModelType {
    
    init(original: RxDataSourcesSection<T>, items: [T]) {
        self = original
        self.items = items
    }
}
