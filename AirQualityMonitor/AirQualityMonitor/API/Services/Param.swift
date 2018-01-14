//
//  Param.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct Param {
    var paramName: String?
    var paramFormula: String?
    var paramCode: String?
    var paramId: Int?
}

extension Param: Decodable {
    enum ParamKeys: String, CodingKey {
        case paramName
        case paramFormula
        case paramCode
        case paramId = "idParam"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ParamKeys.self)
        paramName = try? container.decode(String.self, forKey: .paramName)
        paramFormula = try? container.decode(String.self, forKey: .paramFormula)
        paramCode = try? container.decode(String.self, forKey: .paramCode)
        paramId = try? container.decode(Int.self, forKey: .paramId)
    }
}
