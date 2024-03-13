//
//  JROpportunitiesListVC.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit
import OSLog

extension Logger {
    
    static let opportunitiesListVC = Logger(subsystem: subsystem, category: "JROpportunitiesListVC")
    
}
class JROpportunitiesListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, JREditOpportunityDelegate {
    
    private let ActivityIndicatorOpacity: Float = 0.7
    private let EmptyLabelFontSize: CGFloat = 40
    
    private let opportunitiesService: JROpportunitiesServiceProtocol
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let activityIndicatorView = UIView(frame: .zero)
    private let emptyContentLabel = UILabel(frame: .zero)
    
    private var opportunitiesList = [JROpportunity]()
    
    init(opportunitiesService: JROpportunitiesServiceProtocol) {
        self.opportunitiesService = opportunitiesService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        createLayout();
        fetchOpportunities()
    }
    
    // MARK: - UITableViewDataSource -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opportunitiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = JROpportunityCell(frame: .zero)
        
        newCell.selectionStyle = .none
        newCell.backgroundColor = .clear
        newCell.configureCell(opportunitiesList[indexPath.row])
        
        return newCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        dreamsService.deleteDream(dreamsList[indexPath.row].uuid) {
        //            DispatchQueue.main.async { [weak self] in
        //                guard let self = self else {
        //                    return
        //                }
        //
        //                self.fetchDreamsList()
        //            }
        //        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let viewController = DJDreamDetailsVC.dreamViewController(dreamsList[indexPath.row],
        //                                                                  DJDreamsService((UIApplication.shared.delegate as? AppDelegate)?.coreDataService),
        //                                                                  self)
        //        navigationController?.pushViewController(viewController,
        //                                                 animated: true)
    }
    
    // MARK: - JREditOpportunityDelegate -

    func closeScreen(_ opportunityValue: JROpportunity) {
        dismiss(animated: true)
    }
    
    // MARK: - Handlers -
    
    @objc
    private func newOpportunityButtonTapped(_ sender: UIBarButtonItem) {
        let editVC = JREditOpportunityVC(editOpportunity: nil, opportunitiesService: opportunitiesService)
        editVC.delegate = self
        editVC.modalPresentationStyle = .overFullScreen
        present(editVC, animated: true)
    }
    
    // MARK: - Routine -
    
    private func createLayout() {
        view.backgroundColor = .white

        navigationItem.backButtonTitle = " "
        navigationItem.title = "Jolly Roger"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(newOpportunityButtonTapped(_:)))

        emptyContentLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyContentLabel.isHidden = true
        emptyContentLabel.textAlignment = .center
        emptyContentLabel.font = .etelka(EmptyLabelFontSize)
        emptyContentLabel.numberOfLines = -1
        emptyContentLabel.text = "JROpportunitiesListVC.EmptyList".local
        view.addSubview(emptyContentLabel)
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.color = .white
        spinnerView.startAnimating()
        activityIndicatorView.addSubview(spinnerView)
        NSLayoutConstraint.activate([
            spinnerView.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor)
        ])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.backgroundColor = .black
        activityIndicatorView.layer.opacity = ActivityIndicatorOpacity
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyContentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyContentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func fetchOpportunities() {
        activityIndicatorView.isHidden = false
        Task {
            let listResult = await opportunitiesService.fetchSortedOpportunities()
            DispatchQueue.main.async { [weak self] in
                guard  let self = self else {
                    return
                }
                
                self.activityIndicatorView.isHidden = true
                switch listResult {
                case .success(let list):
                    if list.isEmpty {
                        self.emptyContentLabel.isHidden = false
                    }
                    else {
                        self.emptyContentLabel.isHidden = true
                    }
                    self.opportunitiesList = list
                    self.tableView.reloadData()
                case .failure(let error):
                    switch error {
                    case .emptyOpportunityList:
                        self.emptyContentLabel.isHidden = false
                        self.opportunitiesList = [JROpportunity]()
                        self.tableView.reloadData()
                    default:
                        Logger.opportunitiesListVC.debug("\(error.localizedDescription)")
                        break
                    }
                }
            }
        }
    }
    
}
