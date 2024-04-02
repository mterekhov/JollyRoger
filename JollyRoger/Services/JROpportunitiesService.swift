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
    case opportunityNotFound = "OpportunitiesServiceOpportunityNotFound"

    var localizedDescription: String { return self.rawValue.local }
    
}

protocol JROpportunitiesServiceProtocol {
    
    func createNewOpportunityModel() -> JROpportunity
    func createNewOpportunity() async -> Result<JROpportunity, EOpportunitiesServiceError>
    func findOpportunity(uuid: String) async -> Result<JROpportunity, EOpportunitiesServiceError>
    func fetchSortedOpportunities() async -> Result<[JROpportunity], EOpportunitiesServiceError>
    func updateOpportunity(opportunity: JROpportunity) async -> Result<Void, EOpportunitiesServiceError>
    func deleteOpportunity(opportunity: JROpportunity) async -> Result<Void, EOpportunitiesServiceError>
    
}

class JROpportunitiesService: JROpportunitiesServiceProtocol {
    
    private let coreDataService: JRCoreDataServiceProtocol?
    
    init(coreDataService: JRCoreDataServiceProtocol?) {
        self.coreDataService = coreDataService
    }
    
    // MARK: - JROpportunitiesServiceProtocol -

    func deleteOpportunity(opportunity: JROpportunity) async -> Result<Void, EOpportunitiesServiceError> {
        guard let coreDataService = coreDataService else {
            return .failure(.coreDataError)
        }
        
        let localContext = coreDataService.localContext()
        let searchResults = self.findOpportunity(uuid: opportunity.uuid, localContext: localContext)
        switch searchResults {
        case .success(let coreDataOpportunity):
            localContext.delete(coreDataOpportunity)
            localContext.jollyroger_saveContext()
            return .success(())
        case .failure(let failure):
            return .failure(.opportunityNotFound)
        }
    }

    func updateOpportunity(opportunity: JROpportunity) async -> Result<Void, EOpportunitiesServiceError> {
        guard let coreDataService = coreDataService else {
            return .failure(.coreDataError)
        }
        
        var result: Result<Void, EOpportunitiesServiceError> = .success(())
        let localContext = coreDataService.localContext()
        await localContext.perform { [weak self] in
            guard let self = self else { return }
            
            let searchResults = self.findOpportunity(uuid: opportunity.uuid, localContext: localContext)
            switch searchResults {
            case .success(let coreDataOpportunity):
                self.assignModelToCoreData(coreDataOpportunity, opportunity)
                localContext.jollyroger_saveContext()
                result = .success(())
            case .failure(let failure):
                result = .failure(.opportunityNotFound)
            }
        }
        
        return result
    }

    func createNewOpportunityModel() -> JROpportunity {
        return JROpportunity(uuid: UUID().uuidString,
                             positionTitle: "Developer",
                             companyName: "FAANG",
                             date: Date(),
                             contactName: "John Dow",
                             contactPoint: "telegram",
                             notes: "lorem ipsum",
                             remoteStatus: "fully remote world-wide",
                             salary: "5000$",
                             status: .inProgress)
    }
    
    func createNewOpportunity() async -> Result<JROpportunity, EOpportunitiesServiceError> {
        guard let localContext = coreDataService?.localContext() else {
            return .failure(.coreDataError)
        }

        let newOpportunity = createNewOpportunityModel()
        await localContext.perform { [weak self] in
            guard let self = self else { return }
            let newCoreDataOpportunity = JROpportunityCD(context: localContext)
            assignModelToCoreData(newCoreDataOpportunity, newOpportunity)
            localContext.jollyroger_saveContext()
        }
        
        return .success(newOpportunity)
    }

    func findOpportunity(uuid: String) async -> Result<JROpportunity, EOpportunitiesServiceError> {
        guard let coreDataService = coreDataService else {
            return .failure(.coreDataError)
        }
        
        var result: Result<JROpportunity, EOpportunitiesServiceError> = .failure(.opportunityNotFound)
        let localContext = coreDataService.localContext()
        await localContext.perform { [weak self] in
            guard let self = self else { return }
            
            let searchResults = self.findOpportunity(uuid: uuid, localContext: localContext)
            switch searchResults {
            case .success(let coreDataOpportunity):
                result = .success(self.convertOpportunityIntoViewModel(coreDataOpportunity))
            case .failure(let failure):
                result = .failure(.opportunityNotFound)
            }
        }
        
        return result
    }

    func fetchSortedOpportunities() async -> Result<[JROpportunity], EOpportunitiesServiceError> {
        guard let coreDataService = coreDataService else {
            return .failure(.coreDataError)
        }
        
        let localContext = coreDataService.localContext()
        var result: Result<[JROpportunity], EOpportunitiesServiceError> = .success([])
        
        await localContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: JROpportunityCD.entity().name ?? "")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "status", ascending: true)]

                guard let opportunitiesList = try localContext.fetch(fetchRequest) as? [JROpportunityCD] else {
                    result = .failure(.coreDataError)
                    return
                }
                
                if opportunitiesList.isEmpty {
                    result = .failure(.emptyOpportunityList)
                    return
                }
                
                let convertedList = self.convertOpportunitiesListIntoViewModel(opportunitiesList)
                if convertedList.isEmpty {
                    result = .failure(.emptyOpportunityList)
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
    
    // MARK: - Routine -

    private func findOpportunity(uuid: String, localContext: NSManagedObjectContext) -> Result<JROpportunityCD, EOpportunitiesServiceError> {
        var coreDataOpportunitiesList: [JROpportunityCD]?
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: JROpportunityCD.entity().name ?? "")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", argumentArray: [uuid])
        do {
            coreDataOpportunitiesList = try localContext.fetch(fetchRequest) as? [JROpportunityCD]
        }
        catch let error {
            return.failure(.coreDataError)
        }
        
        guard let opportunitiesList = coreDataOpportunitiesList,
              !opportunitiesList.isEmpty,
              let foundOpportunity = opportunitiesList.first else {
            return .failure(.opportunityNotFound)
        }
        
        return .success(foundOpportunity)
    }

    private func assignModelToCoreData(_ coredata: JROpportunityCD, _ model: JROpportunity) {
        coredata.uuid = model.uuid
        coredata.positionTitle = model.positionTitle
        coredata.companyName = model.companyName
        coredata.date = model.date
        coredata.contactName = model.contactName
        coredata.contactPoint = model.contactPoint
        coredata.notes = model.notes
        coredata.remoteStatus = model.remoteStatus
        coredata.salary = model.salary
        coredata.status = Int64(model.status.rawValue)
    }
    
    private func convertOpportunitiesListIntoViewModel(_ coreDataList: [JROpportunityCD]) -> [JROpportunity] {
        var opportunitiesList = [JROpportunity]()
        
        coreDataList.forEach { coreDataOpportunity in
            opportunitiesList.append(convertOpportunityIntoViewModel(coreDataOpportunity))
        }
        
        return opportunitiesList
    }

    private func convertOpportunityIntoViewModel(_ coreDataOpportunity: JROpportunityCD) -> JROpportunity {
        return JROpportunity(uuid: coreDataOpportunity.uuid ?? "",
                             positionTitle: coreDataOpportunity.positionTitle ?? "",
                             companyName: coreDataOpportunity.companyName ?? "",
                             date: coreDataOpportunity.date ?? Date(),
                             contactName: coreDataOpportunity.contactName ?? "",
                             contactPoint: coreDataOpportunity.contactPoint ?? "",
                             notes: coreDataOpportunity.notes ?? "",
                             remoteStatus: coreDataOpportunity.remoteStatus ?? "",
                             salary: coreDataOpportunity.salary ?? "",
                             status: EOpportunityStatus(rawValue: Int(coreDataOpportunity.status)) ?? EOpportunityStatus.closedAsFailed)
    }

}
