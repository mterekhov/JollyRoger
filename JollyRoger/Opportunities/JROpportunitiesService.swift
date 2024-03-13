//
//  JROpportunitiesService.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import OSLog

typealias FetchOpportunitiesListCompletionHandler = ([JROpportunity]) -> Void

extension Logger {

    static let opportunityService = Logger(subsystem: subsystem, category: "JROpportunitiesService")
    
}

enum EOpportunitiesServiceError: String, LocalizedError {
    
    case coreDataError = "OpportunitiesServiceCoreDataError"

    var localizedDescription: String { return self.rawValue.local }
    
}

protocol JROpportunitiesServiceProtocol {
    
    func fetchSortedOpportunities(_ completionBlock: @escaping FetchOpportunitiesListCompletionHandler)
    
}

class JROpportunitiesService: JROpportunitiesServiceProtocol {
    
    private let coreDataService: JRCoreDataServiceProtocol?
    
    init(coreDataService: JRCoreDataServiceProtocol?) {
        self.coreDataService = coreDataService
    }
    
    func fetchSortedOpportunities(_ completionBlock: @escaping FetchOpportunitiesListCompletionHandler) {
        completionBlock([
            JROpportunity(uuid: UUID().uuidString,
                          positionTitle: "Senior iOS developer",
                          companyName: "Facebook",
                          date: Date(),
                          contactName: "Lena Snake",
                          contactPoint: "telegram",
                          notes: "some notes",
                          remoteStatus: "fully remnote world wide",
                          salary: "5000$",
                          status: EOpportunityStatus.inProgress),
            JROpportunity(uuid: UUID().uuidString,
                          positionTitle: "Team Lead",
                          companyName: "Google",
                          date: Date(),
                          contactName: "Olga",
                          contactPoint: "LinkedIN",
                          notes: "some notes",
                          remoteStatus: "fully remnote world wide",
                          salary: "7000$",
                          status: EOpportunityStatus.inProgress)
        ])
    }
    
}
