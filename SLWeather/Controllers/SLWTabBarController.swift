//
//  ViewController.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import UIKit

class SLWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: TabBarConstants.backgroundImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)

        UITabBar.appearance().tintColor = AppColors.mainColor
        viewControllers                 = [createSearchNC(), createFavoritesNC()]
    }

    func createSearchNC() -> UINavigationController {
        let searchVC = CityWeatherVC()
        searchVC.title = TabBarConstants.search
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoriteCitiesVC()
        favoritesListVC.title = TabBarConstants.favorites
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favoritesListVC)
    }
}

