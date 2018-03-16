//
//  IndexNameEnum.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

enum IndexNameEnum {
    case veryGood, good, moderate, sufficient, bad, veryBad, noValue
    
    init(apiValue: String) {
        switch apiValue {
        case "Bardzo dobry":
            self = .veryGood
        case "Dobry":
            self = .good
        case "Umiarkowany":
            self = .moderate
        case "Dostateczny":
            self = .sufficient
        case "Zły":
            self = .bad
        case "Bardzo zły":
            self = .veryBad
        default:
            self = .noValue
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 6:
            self = .veryGood
        case 5:
            self = .good
        case 4:
            self = .moderate
        case 3:
            self = .sufficient
        case 2:
            self = .bad
        case 1:
            self = .veryBad
        default:
            self = .noValue
        }
    }
    
    var colorValue: UIColor {
        switch self {
        case .veryGood:
            return #colorLiteral(red: 0, green: 0.6655219793, blue: 0.04333889289, alpha: 1)
        case .good:
            return #colorLiteral(red: 0.6285794018, green: 0.9768045545, blue: 0.4099063123, alpha: 1)
        case .moderate:
            return #colorLiteral(red: 0.9992190003, green: 0.9976102364, blue: 0.1975404303, alpha: 1)
        case .sufficient:
            return #colorLiteral(red: 0.9992190003, green: 0.7039459348, blue: 0, alpha: 1)
        case .bad:
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .veryBad:
            return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        case .noValue:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .noValue:
            return .black
        default:
            return .white
        }
    }
    
    var textValue: String {
        switch self {
        case .veryGood:
            return "VeryGood".localized
        case .good:
            return "Good".localized
        case .moderate:
            return "Moderate".localized
        case .sufficient:
            return "Sufficient".localized
        case .bad:
            return "Bad".localized
        case .veryBad:
            return "VeryBad".localized
        case .noValue:
            return "NoData".localized
        }
    }
    
    var rawValue: Int {
        switch self {
        case .veryGood:
            return 6
        case .good:
            return 5
        case .moderate:
            return 4
        case .sufficient:
            return 3
        case .bad:
            return 2
        case .veryBad:
            return 1
        case .noValue:
            return 7
        }
    }
}
