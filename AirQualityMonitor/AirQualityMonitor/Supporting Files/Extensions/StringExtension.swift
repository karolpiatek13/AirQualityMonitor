//
//  DateExtension.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

extension String {
    
    func toChartDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    
        let dateObj = dateFormatter.date(from: self)
    
        dateFormatter.dateFormat = "dd hh:mm"
        guard let date = dateObj else { return "" }
        return dateFormatter.string(from: date)
    }
}
