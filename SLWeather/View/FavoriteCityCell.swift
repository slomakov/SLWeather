//
//  FavoriteCityCell.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 16.01.2024.
//

import UIKit

class FavoriteCityCell: UITableViewCell {

    static let reuseID  = "FavoriteCityCell"
    let cityLabel = SLWLabel(textAlignment: .left, fontSize: 26)
    let tempLabel = SLWLabel(textAlignment: .right, fontSize: 26)
    let conditionImageView = SLWImageView(frame: .zero)
    let cellStack = UIStackView()
    let tempConditionStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = weather.temperatureString + AppConstants.degreeSymbol
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }

    private func configureCellStack() {
        cellStack.axis = .horizontal
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellStack)

        cellStack.addArrangedSubview(cityLabel)
        configureTempConditionStackStack()
        cellStack.addArrangedSubview(tempConditionStack)

        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    private func configureTempConditionStackStack() {
        tempConditionStack.distribution = .fillEqually
        tempConditionStack.axis = .horizontal
        tempConditionStack.spacing = 8
        tempConditionStack.widthAnchor.constraint(equalToConstant: 130).isActive = true
        tempConditionStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellStack)

        tempConditionStack.addArrangedSubview(conditionImageView)
        tempConditionStack.addArrangedSubview(tempLabel)
    }
}
