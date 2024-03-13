//
//  File.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import Foundation

extension DateFormatter {
    
    static public func jollyroger_dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }
    
}
