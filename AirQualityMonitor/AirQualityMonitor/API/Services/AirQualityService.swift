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
        case .stationSensors:
            return "station/sensors"
        case .sensorData:
            return "data/getData"
        case .stationData:
            return "aqindex/getIndex"
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
        case let .stationSensors(id):
            return .requestParameters(parameters: ["stationId": id], encoding: URLEncoding.queryString)
        case let .sensorData(id):
            return .requestParameters(parameters: ["sensorId": id], encoding: URLEncoding.queryString)
        case let .stationData(id):
            return .requestParameters(parameters: ["stationId": id], encoding: URLEncoding.queryString)
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
