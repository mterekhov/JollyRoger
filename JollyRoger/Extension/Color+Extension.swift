//
//  Color+Extension.swift
//  JollyRoger
//
//  Created by cipher on 15.03.2024.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex & 0x0000FF) / divisor
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func pirateBlue() -> UIColor {
        return UIColor(hex: 0x2782FF)
    }
    
    static func pirateAlto() -> UIColor {
        return UIColor(hex: 0xE0E0E0)
    }
    
    static func pirateAlphaBlack() -> UIColor {
        return .black.withAlphaComponent(0.7)
    }
    
}
