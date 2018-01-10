//
//  IndexLevel.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct IndexLevel {
    var id: Int?
    var indexLevelName: String?
}

extension IndexLevel: Decodable {
    enum IndexLevelKeys: String, CodingKey {
        case id
        case indexLevelName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IndexLevelKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        indexLevelName = try? container.decode(String.self, forKey: .indexLevelName)
    }
}
