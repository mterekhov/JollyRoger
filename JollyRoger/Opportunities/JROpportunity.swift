//
//  JROpportunity.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

enum EOpportunityStatus {
    
    case inProgress
    case finished
    case closedAsFailed
    case closedAsOffer

    var color: UIColor {
        switch self {
        case .inProgress:
            return UIColor.systemYellow
        case .finished:
            return UIColor.systemGray
        case .closedAsFailed:
            return UIColor.systemRed
        case .closedAsOffer:
            return UIColor.systemGreen
        }
    }
    
}

struct JROpportunity {

    var uuid = ""
    var positionTitle = ""
    var companyName = ""
    var date = Date()

    var contactName = ""
    var contactPoint = ""
    var notes = ""
    var remoteStatus = ""
    var salary = ""
    var status = EOpportunityStatus.inProgress

}
