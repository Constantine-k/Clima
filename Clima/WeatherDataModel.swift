//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Konstantin Konstantinov on 11/18/17.
//  Copyright © 2017 Konstantin Konstantinov. All rights reserved.
//

import UIKit

class WeatherDataModel {

    var temperature: Int
    var condition: Int
    var city: String
    var weatherIconName: String {
        return updateWeatherIcon(condition: condition)
    }
    
    init(temperature: Int, condition: Int, city: String) {
        self.temperature = temperature
        self.condition = condition
        self.city = city
    }
    
    // Returns the weather condition image name
    private func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "tstorm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "shower3"
        case 601...700 :
            return "snow4"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "tstorm3"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy2"
        case 900...903, 905...1000  :
            return "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "unknown"
        }
    }
    
}
