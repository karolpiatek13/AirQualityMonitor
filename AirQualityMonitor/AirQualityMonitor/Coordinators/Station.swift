//
//  Station.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct Station {
    var id: Int?
    var stationName: String?
    var gegrLat: Double?
    var gegrLon: Double?
    var city: City?
}

extension Station: Decodable {
    enum StationKeys: String, CodingKey {
        case id = "id"
        case stationName = "stationName"
        case gegrLat = "gegrLat"
        case gegrLon = "gegrLon"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StationKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        stationName = try? container.decode(String.self, forKey: .stationName)
        gegrLat = try? container.decode(Double.self, forKey: .gegrLat)
        gegrLon = try? container.decode(Double.self, forKey: .gegrLon)
        city = try? container.decode(City.self, forKey: .city)
    }
}
