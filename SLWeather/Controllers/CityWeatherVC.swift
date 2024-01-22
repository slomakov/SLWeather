//
//  SearchCityVC.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 14.01.2024.
//

import UIKit
import CoreLocation

class CityWeatherVC: UIViewController {

    let topOffset: CGFloat = 20
    let btnOffset: CGFloat = 50
    let locationManager = CLLocationManager()

    let searchCityTextField = SearchTextField()
    let getLocationButton = SLWButton(
                                    color: AppColors.mainColor,
                                    title: ElementsText.location,
                                    systemImageName: SFSymbols.location)
    let getWeatherButton = SLWButton(
                                    color: AppColors.mainColor,
                                    title: ElementsText.getWeather,
                                    systemImageName: SFSymbols.getWeather)
    let addToFavoriteButton = SLWButton(
                                    color: AppColors.mainColor,
                                    title: ElementsText.addToFavorite,
                                    systemImageName: SFSymbols.addToFavorite)
    
    let conditionImageView = SLWImageView(frame: .zero)
    let temperatureLabel = SLWLabel(textAlignment: .center, fontSize: 30)
    let cityLabel = SLWLabel(textAlignment: .center, fontSize: 30)

    var isCityNameEntered: Bool { !searchCityTextField.text!.isEmpty }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(searchCityTextField, getWeatherButton, conditionImageView, cityLabel, temperatureLabel, addToFavoriteButton, getLocationButton)

        locationManager.delegate = self
        searchCityTextField.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        configureSearchTextField()
        configureGetWeatherButton()
        createDismissKeyboardTapGesture()
        configureConditionImageView()
        configureCityLabel()
        configureTemperatureLabel()
        configureAddToFavoriteButton()
        configureGetLocationButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCityTextField.text = ""
    }

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    func updateWeather(with weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString + AppConstants.celsiusSymbol
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }

    @objc func requestLocation() {
        locationManager.requestLocation()
        addToFavoriteButton.isEnabled = true
    }

    @objc func addToFavoriteClicked() {
        if let city = cityLabel.text {
            PersistenceManager.updateWith(city: city, actionType: .add) { [weak self] error in
                guard let self else { return }
                guard let error else { return}

                self.presentAlert(title: AlertMessages.oops, message: error.rawValue, buttonTitle: AlertMessages.ok)
            }
            self.presentAlert(title: AlertMessages.success, message: city + AlertMessages.added, buttonTitle: AlertMessages.ok)
            addToFavoriteButton.isEnabled = false
        }
    }

    @objc func getWeatherButtonClicked() {
        guard isCityNameEntered else { return }

        addToFavoriteButton.isEnabled = true
        searchCityTextField.endEditing(true)
        searchCityTextField.resignFirstResponder()
    }

    func configureSearchTextField() {
        searchCityTextField.delegate = self

        NSLayoutConstraint.activate([
            searchCityTextField.topAnchor.constraint(equalTo: getLocationButton.bottomAnchor, constant: topOffset),
            searchCityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            searchCityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset),
            searchCityTextField.heightAnchor.constraint(equalToConstant: btnOffset)
        ])
    }

    func configureGetLocationButton() {
        getLocationButton.addTarget(self, action: #selector(requestLocation), for: .touchUpInside)

        NSLayoutConstraint.activate([
            getLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topOffset),
            getLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            getLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset),
            getLocationButton.heightAnchor.constraint(equalToConstant: btnOffset)
        ])
    }

    func configureGetWeatherButton() {
        getWeatherButton.addTarget(self, action: #selector(getWeatherButtonClicked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            getWeatherButton.topAnchor.constraint(equalTo: searchCityTextField.bottomAnchor, constant: topOffset),
            getWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            getWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset),
            getWeatherButton.heightAnchor.constraint(equalToConstant: btnOffset)
        ])
    }

    func configureConditionImageView() {
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalTo: getWeatherButton.bottomAnchor, constant: topOffset),
            conditionImageView.heightAnchor.constraint(equalToConstant: 100),
            conditionImageView.widthAnchor.constraint(equalToConstant: 100),
            conditionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func configureCityLabel() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: topOffset),
            cityLabel.heightAnchor.constraint(equalToConstant: btnOffset),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset)
        ])
    }

    func configureTemperatureLabel() {
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: topOffset),
            temperatureLabel.heightAnchor.constraint(equalToConstant: btnOffset),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset)
        ])
    }

    func configureAddToFavoriteButton() {
        addToFavoriteButton.addTarget(self, action: #selector(addToFavoriteClicked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addToFavoriteButton.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: topOffset),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnOffset),
            addToFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -btnOffset),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: btnOffset)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension CityWeatherVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCityTextField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard isCityNameEntered else { return }
        
        if let city = searchCityTextField.text {
            NetworkManager.shared.fetchWeather(cityName: city) { [weak self] result in
                guard let self else { return }

                switch result {
                case .success(let weather):
                    updateWeather(with: weather)
                case .failure(let error):
                    self.presentAlert(title: AlertMessages.oops, message: error.rawValue, buttonTitle: AlertMessages.ok)
                }
            }
        }
        searchCityTextField.text = ""
    }
}

//MARK: - CLLocationManagerDelegate

extension CityWeatherVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            NetworkManager.shared.fetchWeather(latitude: lat, longitude: lon) { [weak self] result in
                guard let self else { return }

                switch result {
                case .success(let weather):
                    updateWeather(with: weather)
                case .failure(let error):
                    self.presentAlert(title: AlertMessages.oops, message: error.rawValue, buttonTitle: AlertMessages.ok)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.presentAlert(title: AlertMessages.oops, message: AlertMessages.badLocation, buttonTitle: AlertMessages.ok)
    }
}
