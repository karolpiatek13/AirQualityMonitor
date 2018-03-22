//
//  City.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct City {
    var id: Int?
    var name: String?
    var commune: Commune?
}

extension City: Decodable {
    enum CityKeys: String, CodingKey {
        case id
        case name
        case commune
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        commune = try? container.decode(Commune.self, forKey: .commune)
    }
}
