//
//  AirQuality.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation

struct AirQualityIndex {
    var stCalcDate: String?
    var stIndexLevel: IndexLevel?
    var so2CalcDate: String?
    var so2IndexLevel: IndexLevel?
    var no2CalcDate: String?
    var no2IndexLevel: IndexLevel?
    var coCalcDate: String?
    var coIndexLevel: IndexLevel?
    var pm10CalcDate: String?
    var pm10IndexLevel: IndexLevel?
    var pm25CalcDate: String?
    var pm25IndexLevel: IndexLevel?
    var o3CalcDate: String?
    var o3IndexLevel: IndexLevel?
    var c6h6CalcDate: String?
    var c6h6IndexLevel: IndexLevel?
}

extension AirQualityIndex {
    
    func getValueFrom(code: String) -> (String?, String?) {
        switch code {
        case "ST":
            return (stIndexLevel?.indexLevelName, stCalcDate)
        case "SO2":
            return (so2IndexLevel?.indexLevelName, so2CalcDate)
        case "NO2":
            return (no2IndexLevel?.indexLevelName, no2CalcDate)
        case "CO":
            return (coIndexLevel?.indexLevelName, coCalcDate)
        case "PM10":
            return (pm10IndexLevel?.indexLevelName, pm10CalcDate)
        case "PM25":
            return (pm25IndexLevel?.indexLevelName, pm25CalcDate)
        case "O3":
            return (o3IndexLevel?.indexLevelName, o3CalcDate)
        case "C6H6":
            return (c6h6IndexLevel?.indexLevelName, c6h6CalcDate)
        default:
            return ("", "")
        }
    }
    
    func assignValues(measurements: [Measurement]) -> [Measurement] {
        return measurements.map {
            let tuple = getValueFrom(code: $0.code)
            $0.indexLevelEnum = IndexNameEnum(apiValue: tuple.0 ?? "")
            $0.date = tuple.1
            return $0
        }
    }
}

extension AirQualityIndex: Decodable {
    enum AirQualityIndexKeys: String, CodingKey {
        case stCalcDate
        case stIndexLevel
        
        case so2CalcDate
        case so2IndexLevel
        
        case no2CalcDate
        case no2IndexLevel
        
        case coCalcDate
        case coIndexLevel
        
        case pm10CalcDate
        case pm10IndexLevel
        
        case pm25CalcDate
        case pm25IndexLevel
        
        case o3CalcDate
        case o3IndexLevel
        
        case c6h6CalcDate
        case c6h6IndexLevel
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AirQualityIndexKeys.self)
        
        stCalcDate = try? container.decode(String.self, forKey: .stCalcDate)
        stIndexLevel = try? container.decode(IndexLevel.self, forKey: .stIndexLevel)
        
        so2CalcDate = try? container.decode(String.self, forKey: .so2CalcDate)
        so2IndexLevel = try? container.decode(IndexLevel.self, forKey: .so2IndexLevel)
        
        no2CalcDate = try? container.decode(String.self, forKey: .no2CalcDate)
        no2IndexLevel = try? container.decode(IndexLevel.self, forKey: .no2IndexLevel)
        
        coCalcDate = try? container.decode(String.self, forKey: .coCalcDate)
        coIndexLevel = try? container.decode(IndexLevel.self, forKey: .coIndexLevel)
        
        pm10CalcDate = try? container.decode(String.self, forKey: .pm10CalcDate)
        pm10IndexLevel = try? container.decode(IndexLevel.self, forKey: .pm10IndexLevel)
        
        pm25CalcDate = try? container.decode(String.self, forKey: .pm25CalcDate)
        pm25IndexLevel = try? container.decode(IndexLevel.self, forKey: .pm25IndexLevel)
        
        o3CalcDate = try? container.decode(String.self, forKey: .o3CalcDate)
        o3IndexLevel = try? container.decode(IndexLevel.self, forKey: .o3IndexLevel)
        
        c6h6CalcDate = try? container.decode(String.self, forKey: .c6h6CalcDate)
        c6h6IndexLevel = try? container.decode(IndexLevel.self, forKey: .c6h6IndexLevel)
    }
}
