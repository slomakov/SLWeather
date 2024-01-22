//
//  Constants.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 19.01.2024.
//

import UIKit

enum SFSymbols {
    static let location = "location.circle"
    static let getWeather = "magnifyingglass"
    static let addToFavorite = "plus"
}

enum ElementsText {
    static let location = "Your location"
    static let getWeather = "Get Weater"
    static let addToFavorite = "Add to favorite"
    static let searchFieldPlaceholder = "Enter a city"
}

enum AlertMessages {
    static let ok = "Ok"
    static let oops = "Oops"
    static let success = "Success!"
    static let badLocation = "Cannot identify your location"
    static let added = " added to favorite"
}

enum AppConstants {
    static let degreeSymbol = "°"
    static let celsiusSymbol = "°C"
}

enum TabBarConstants {
    static let search = "Search"
    static let favorites = "Favorites"
    static let backgroundImageName = "bckgrnd"
}

enum AppColors {
    static let mainColor = UIColor.systemGreen
}

enum Networking {
    static let urlStart = "https://api.openweathermap.org/data/2.5/weather?appid="
    static let openWeatherToken = "2224d18e3a7168f1cf732d5121074ef9"
    static let celsiusParameter = "&units=metric"
}
