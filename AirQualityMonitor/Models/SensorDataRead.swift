//
//  SensorDataRead.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct SensorDataRead {
    var date: String?
    var value: Double?
}

extension SensorDataRead: Decodable {
    enum SensorDataReadKeys: String, CodingKey {
        case date
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SensorDataReadKeys.self)
        date = try? container.decode(String.self, forKey: .date)
        value = try? container.decode(Double.self, forKey: .value)
    }
}
