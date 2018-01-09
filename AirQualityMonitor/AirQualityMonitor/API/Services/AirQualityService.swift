//
//  AirQualityService.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Moya

enum AirQualityService {
    case allStations
    case stationSensors(id: Int)
    case sensorData(id: Int)
    case stationData(id: Int)
}

extension AirQualityService: TargetType {
    
    var baseURL: URL { return URL(string: Constants.baseUrl)! }
    
    var path: String {
        switch self {
        case .allStations:
            return "station/findAll"
        case .stationSensors(let id):
            return "station/sensors/\(id)"
        case .sensorData(let id):
            return "data/getData/\(id)"
        case .stationData(let id):
            return "aqindex/getIndex/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allStations,
             .stationSensors,
             .sensorData,
             .stationData:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data("Half measures are as bad as nothing at all.".utf8)
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
}
