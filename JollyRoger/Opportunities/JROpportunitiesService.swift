//
//  JROpportunitiesService.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import OSLog
import CoreData

extension Logger {

    static let opportunityService = Logger(subsystem: subsystem, category: "JROpportunitiesService")
    
}

enum EOpportunitiesServiceError: String, LocalizedError {
    
    case coreDataError = "OpportunitiesServiceCoreDataError"
    case emptyOpportunityList = "OpportunitiesServiceEmptyOpportunityList"

    var localizedDescription: String { return self.rawValue.local }
    
}

protocol JROpportunitiesServiceProtocol {
    
    func fetchSortedOpportunities() async -> Result<[JROpportunity], EOpportunitiesServiceError>
    
}

class JROpportunitiesService: JROpportunitiesServiceProtocol {
    
    private let coreDataService: JRCoreDataServiceProtocol?
    
    init(coreDataService: JRCoreDataServiceProtocol?) {
        self.coreDataService = coreDataService
    }
    
    func fetchSortedOpportunities() async -> Result<[JROpportunity], EOpportunitiesServiceError> {
        guard let coreDataService = coreDataService else {
            return .failure(.coreDataError)
        }
        
        let localContext = coreDataService.localContext()
        var result: Result<[JROpportunity], EOpportunitiesServiceError> = .success([])
        
        await localContext.perform {
            do {
                guard let opportunitiesList = try localContext.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: JROpportunityCD.entity().name ?? "")) as? [JROpportunityCD] else {
                    result = .failure(.coreDataError)
                    return
                }
                
                if opportunitiesList.isEmpty {
                    result = .failure(.emptyOpportunityList)
                    return
                }
                
                guard let convertedList = self.convertOpportunitiesListIntoViewModel(opportunitiesList) else {
                    result = .failure(.coreDataError)
                    return
                }
                result = .success(convertedList)
            }
            catch (let error) {
                result = .failure(.coreDataError)
            }
        }
        
        return result
    }
    
    private func convertOpportunitiesListIntoViewModel(_ coreDataList: [JROpportunityCD]) -> [JROpportunity]? {
        var opportunitiesList: [JROpportunity]?
        
        coreDataList.forEach { coreDataOpportunity in
            opportunitiesList?.append(JROpportunity(uuid: coreDataOpportunity.uuid ?? "",
                                                    positionTitle: coreDataOpportunity.positionTitle ?? "",
                                                    companyName: coreDataOpportunity.companyName ?? "",
                                                    date: coreDataOpportunity.date ?? Date(),
                                                    contactName: coreDataOpportunity.contactName ?? "",
                                                    contactPoint: coreDataOpportunity.contactPoint ?? "",
                                                    notes: coreDataOpportunity.notes ?? "",
                                                    remoteStatus: coreDataOpportunity.remoteStatus ?? "",
                                                    salary: coreDataOpportunity.salary ?? "",
                                                    status: EOpportunityStatus(rawValue: Int(coreDataOpportunity.status)) ?? EOpportunityStatus.closedAsFailed))
        }
        
        return opportunitiesList
    }
    
}
