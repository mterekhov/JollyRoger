//
//  JROpportunity.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

enum EOpportunityStatus: Int {
    
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
    
    var title: String {
        switch self {
        case .inProgress:
            return "StatusInProgress".local
        case .finished:
            return "StatusFinished".local
        case .closedAsFailed:
            return "StatusClosedAsFailed".local
        case .closedAsOffer:
            return "StatusClosedAsOffer".local
        }
    }
    
}

struct JROpportunity {
    
    init(uuid: String, opportunity: JROpportunity) {
        self.uuid = uuid
        self.positionTitle = opportunity.positionTitle
        self.companyName = opportunity.companyName
        self.date = opportunity.date
        self.contactName = opportunity.contactName
        self.contactPoint = opportunity.contactPoint
        self.notes = opportunity.notes
        self.remoteStatus = opportunity.remoteStatus
        self.salary = opportunity.salary
        self.status = opportunity.status
    }
    
    init(uuid: String, 
         positionTitle: String,
         companyName: String,
         date: Date,
         contactName: String,
         contactPoint: String,
         notes: String,
         remoteStatus: String,
         salary: String,
         status: EOpportunityStatus) {
        self.uuid = uuid
        self.positionTitle = positionTitle
        self.companyName = companyName
        self.date = date
        self.contactName = contactName
        self.contactPoint = contactPoint
        self.notes = notes
        self.remoteStatus = remoteStatus
        self.salary = salary
        self.status = status
    }

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
