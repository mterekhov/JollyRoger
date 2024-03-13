//
//  Font+extension.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

extension UIFont {

    static public func etelka(_ size: CGFloat = 17) -> UIFont {
        return UIFont(name: "EtelkaMediumPro", size: size) ?? .systemFont(ofSize: size)
    }
    
}
