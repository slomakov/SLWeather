//
//  FavoriteCitiesVC.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import UIKit

class FavoriteCitiesVC: UIViewController {

    let tableView = UITableView()
    var favorites: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavorites()
    }

    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }

            switch result {
                case .success(let favorites):
                    self.favorites = favorites
                    updateUI()
                case .failure(let error):
                    self.presentAlert(title: AlertMessages.oops, message: error.rawValue, buttonTitle: AlertMessages.ok)
            }
        }
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }

    func configureTableView() {
        view.addSubview(tableView)

        tableView.backgroundColor = UIColor.clear
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FavoriteCityCell.self, forCellReuseIdentifier: FavoriteCityCell.reuseID)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoriteCitiesVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCityCell.reuseID) as! FavoriteCityCell
        cell.backgroundColor = UIColor.clear
        let favorite = favorites[indexPath.row]

        NetworkManager.shared.fetchWeather(cityName: favorite) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let weather):
                cell.set(weather: weather)
            case .failure(let error):
                self.presentAlert(title: AlertMessages.oops, message: error.rawValue, buttonTitle: AlertMessages.ok)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(city: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard error != nil else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
        }
    }
}
