//
//  SLWImageView.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 15.01.2024.
//

import UIKit

class SLWImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        tintColor = AppColors.mainColor
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
