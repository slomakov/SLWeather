//
//  WeatherModel.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import Foundation

struct WeatherModel: Decodable {
    let conditionId: Int
    let cityName: String
    let temperature: Double

    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }

    // According to https://openweathermap.org/weather-conditions
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

}
