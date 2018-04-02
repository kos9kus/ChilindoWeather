//
//  WeatherDate.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 31/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import UIKit
import SwiftDate

class WeatherDate {
    private static let dateFormate = "d MMM, EE HH:mm"
    
    static var nowDate: String {
        return Date().string(format: .custom(self.dateFormate))
    }
    
    static func formattedDataString(timeInterval: TimeInterval) -> String {
        return Date(timeIntervalSince1970: timeInterval).string(format: .custom(WeatherDate.dateFormate))
    }
}
