//
//  JROpportunitiesListVC.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

class JROpportunitiesListVC: UIViewController {

    private let coreDataService: JRCoreDataServiceProtocol?

    init(coreDataService: JRCoreDataServiceProtocol?) {
        self.coreDataService = coreDataService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        createLayout();
        view.backgroundColor = .cyan
    }
    
    private func createLayout() {
        
    }
    
}

