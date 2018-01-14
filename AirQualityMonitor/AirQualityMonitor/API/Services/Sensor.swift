//
//  Sensor.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct Sensor {
    var id: Int?
    var stationId: Int?
    var param: Param?
}

extension Sensor: Decodable {
    enum SensorKeys: String, CodingKey {
        case id
        case stationId
        case param
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SensorKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        stationId = try? container.decode(Int.self, forKey: .stationId)
        param = try? container.decode(Param.self, forKey: .param)
    }
}
