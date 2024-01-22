//
//  SLWeatherTests.swift
//  SLWeatherTests
//
//  Created by Stanislav Lomakov on 21.01.2024.
//

import XCTest
@testable import SLWeather

final class SLWeatherModelTests: XCTestCase {

    let testCityName = "Cupertino"
    let temp: Double = 19

    func testWeatherModel() {
        testConditionID(range: Array(200...232), expectedSFSymbolName: "cloud.bolt")
        testConditionID(range: Array(300...321), expectedSFSymbolName: "cloud.drizzle")
        testConditionID(range: Array(500...531), expectedSFSymbolName: "cloud.rain")
        testConditionID(range: Array(600...622), expectedSFSymbolName: "cloud.snow")
        testConditionID(range: Array(701...781), expectedSFSymbolName: "cloud.fog")
        testConditionID(range: Array(801...804), expectedSFSymbolName: "cloud.bolt")
        testConditionID(range: Array(arrayLiteral: 800), expectedSFSymbolName: "sun.max")

        // Default SFSymbol is "cloud" for out of range values https://openweathermap.org/weather-conditions
        testConditionID(range: Array(arrayLiteral: 199, 233, 299, 322, 499, 532, 599, 623, 700, 805), expectedSFSymbolName: "cloud")
    }

    private func testConditionID(range: [Int], expectedSFSymbolName: String) {
        range.forEach({
            let weather = WeatherModel(conditionId: $0, cityName: testCityName, temperature: temp)
            XCTAssertEqual(weather.conditionName, expectedSFSymbolName, "Incorrect SFSymbol name")
        })
    }
}
