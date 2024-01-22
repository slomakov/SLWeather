//
//  SLWError.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import Foundation

enum SLWError: String, Error {
    case invalidCityName = "This city created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this city. Please try again."
    case alreadyInFavorites = "You've already favorited this city. You must REALLY like it!"
}
