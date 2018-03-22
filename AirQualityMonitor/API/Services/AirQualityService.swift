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
        case .allStations:
            return Data("[{\"id\":114,\"stationName\":\"Wrocław - Bartnicza\",\"gegrLat\":\"51.115933\",\"gegrLon\":\"17.141125\",\"city\":{\"id\":1064,\"name\":\"Wrocław\",\"commune\":{\"communeName\":\"Wrocław\",\"districtName\":\"Wrocław\",\"provinceName\":\"DOLNOŚLĄSKIE\"}},\"addressStreet\":\"ul. Bartnicza\"},{\"id\":117,\"stationName\":\"Wrocław - Korzeniowskiego\",\"gegrLat\":\"51.129378\",\"gegrLon\":\"17.029250\",\"city\":{\"id\":1064,\"name\":\"Wrocław\",\"commune\":{\"communeName\":\"Wrocław\",\"districtName\":\"Wrocław\",\"provinceName\":\"DOLNOŚLĄSKIE\"}},\"addressStreet\":\"ul. Wyb. J.Conrada-Korzeniowskiego 18\"}]".utf8)
        case .stationSensors:
            return Data("[{\"id\":642,\"stationId\":114,\"param\":{\"paramName\":\"dwutlenek azotu\",\"paramFormula\":\"NO2\",\"paramCode\":\"NO2\",\"idParam\":6}},{\"id\":644,\"stationId\":114,\"param\":{\"paramName\":\"ozon\",\"paramFormula\":\"O3\",\"paramCode\":\"O3\",\"idParam\":5}}]".utf8)
        case .sensorData:
            return Data("{\"key\":\"NO2\",\"values\":[{\"date\":\"2018-03-20 11:00:00\",\"value\":28.7326},{\"date\":\"2018-03-20 10:00:00\",\"value\":34.7591},{\"date\":\"2018-03-20 09:00:00\",\"value\":42.5064}]}".utf8)
        case .stationData:
            return Data("{\"id\":114,\"stCalcDate\":\"2018-03-20 11:19:56\",\"stIndexLevel\":{\"id\":-1,\"indexLevelName\":\"Brak indeksu\"},\"stSourceDataDate\":\"2018-03-20 11:00:00\",\"so2CalcDate\":null,\"so2IndexLevel\":null,\"so2SourceDataDate\":null,\"no2CalcDate\":1521541196000,\"no2IndexLevel\":{\"id\":0,\"indexLevelName\":\"Bardzo dobry\"},\"no2SourceDataDate\":\"2018-03-20 11:00:00\",\"coCalcDate\":null,\"coIndexLevel\":null,\"coSourceDataDate\":null,\"pm10CalcDate\":null,\"pm10IndexLevel\":null,\"pm10SourceDataDate\":null,\"pm25CalcDate\":null,\"pm25IndexLevel\":null,\"pm25SourceDataDate\":null,\"o3CalcDate\":\"2018-03-20 11:19:56\",\"o3IndexLevel\":{\"id\":1,\"indexLevelName\":\"Dobry\"},\"o3SourceDataDate\":\"2018-03-20 11:00:00\",\"c6h6CalcDate\":null,\"c6h6IndexLevel\":null,\"c6h6SourceDataDate\":null,\"stIndexStatus\":false,\"stIndexCrParam\":\"PYL\"}".utf8)
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
