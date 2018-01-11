//
//  SensorData.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct SensorData {
    var key: String?
    var values: [SensorDataRead]?
}

extension SensorData: Decodable {
    enum SensorDataKeys: String, CodingKey {
        case key
        case values
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SensorDataKeys.self)
        key = try? container.decode(String.self, forKey: .key)
        values = try? container.decode([SensorDataRead].self, forKey: .values)
    }
}
