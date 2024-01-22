//
//  UIView+Ext.swift
//  SLWeather
//
//  Created by Stanislav Lomakov on 15.01.2024.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
