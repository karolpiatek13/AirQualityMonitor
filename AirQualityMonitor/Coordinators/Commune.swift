//
//  Commune.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct Commune {
    var name: String?
    var district: String?
    var province: String?
}

extension Commune: Decodable {
    enum CommuneKeys: String, CodingKey {
        case name = "communeName"
        case district = "districtName"
        case province = "provinceName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CommuneKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        district = try? container.decode(String.self, forKey: .district)
        province = try? container.decode(String.self, forKey: .province)
    }
}
