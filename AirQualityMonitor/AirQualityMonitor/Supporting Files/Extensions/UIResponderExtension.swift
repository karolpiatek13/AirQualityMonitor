//
//  UIResponderExtension.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension UIResponder {
    static var typeName: String {
        return String(describing: self)
    }
}

