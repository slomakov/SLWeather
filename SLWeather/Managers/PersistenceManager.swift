//
//  PersistenceManager.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }


    static func updateWith(city: String, actionType: PersistenceActionType, completed: @escaping (SLWError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):

                switch actionType {
                case .add:
                    guard !favorites.contains(city) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(city)

                case .remove:
                    favorites.removeAll { $0 == city }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[String], SLWError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([String].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    static func save(favorites: [String]) -> SLWError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
