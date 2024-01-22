//
//  NetworkManager.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import UIKit
import CoreLocation


class NetworkManager {

    static let shared = NetworkManager()

    private let baseURL = Networking.urlStart + Networking.openWeatherToken + Networking.celsiusParameter

    private init() { }

    
    func fetchWeather(cityName: String, completed: @escaping (Result<WeatherModel, SLWError>) -> Void) {
        let urlString = "\(baseURL)&q=\(cityName)"
        performRequest(with: urlString, completed: completed)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completed: @escaping (Result<WeatherModel, SLWError>) -> Void) {
        let urlString = "\(baseURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString, completed: completed)
    }

    func performRequest(with urlString: String, completed: @escaping (Result<WeatherModel, SLWError>) -> Void) {

        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidCityName))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                let id = weatherData.weather[0].id
                let temp = weatherData.main.temp
                let name = weatherData.name
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)

                completed(.success(weather))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//            return weather
//
//        } catch {
//            delegate?.didFailWithError(error: .invalidData)
//            return nil
//        }
//    }
}
