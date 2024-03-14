//
//  JREditOpportunityVC.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//
import UIKit
import OSLog

extension Logger {
    
    static let createOpportunityVC = Logger(subsystem: subsystem, category: "JRCreateOpportunityVC")
    
}

enum EOpportunityField: Int {
    
    case positionTitle
    case companyName
    case contactName
    case contactPoint
    case notes
    case remoteStatus
    case salary
    case date
    case status
    
    case size
    
}

protocol JREditOpportunityDelegate: AnyObject {
    
    func saveOpportunity(_ opportunityValue: JROpportunity)
    func closeScreen()

}

class JREditOpportunityVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let CloseButtonLeftOffset: CGFloat = 25

    private var opportunity: JROpportunity
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    weak var delegate: JREditOpportunityDelegate?

    init(editOpportunity: JROpportunity) {
        opportunity = editOpportunity

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        createLayout();
    }
    
    // MARK: - UITableViewDataSource -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EOpportunityField.size.rawValue - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = JREditFieldCell(frame: .zero)
        newCell.selectionStyle = .none
        newCell.backgroundColor = .cyan
        
        let field = EOpportunityField(rawValue: indexPath.row)
        switch field {
        case .positionTitle:
            newCell.configureCell("Position", opportunity.positionTitle) { newText in
                if let newText = newText {
                    self.opportunity.positionTitle = newText
                }
            }
        case .companyName:
            newCell.configureCell("Company", opportunity.companyName) { newText in
                if let newText = newText {
                    self.opportunity.companyName = newText
                }
            }
        case .contactName:
            newCell.configureCell("Contact", opportunity.contactName) { newText in
                if let newText = newText {
                    self.opportunity.contactName = newText
                }
            }
        case .contactPoint:
            newCell.configureCell("Contact point", opportunity.contactPoint) { newText in
                if let newText = newText {
                    self.opportunity.contactPoint = newText
                }
            }
        case .notes:
            newCell.configureCell("Notes", opportunity.notes) { newText in
                if let newText = newText {
                    self.opportunity.notes = newText
                }
            }
        case .remoteStatus:
            newCell.configureCell("Remote", opportunity.remoteStatus) { newText in
                if let newText = newText {
                    self.opportunity.remoteStatus = newText
                }
            }
        case .salary:
            newCell.configureCell("Salary", opportunity.salary) { newText in
                if let newText = newText {
                    self.opportunity.salary = newText
                }
            }
        case .date:
            newCell.configureCell("Date", DateFormatter.jollyroger_dateFormatter().string(from: opportunity.date)) { newText in
                if let newText = newText {
                    self.opportunity.salary = newText
                }
            }
        default:
            break
        }

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let viewController = DJDreamDetailsVC.dreamViewController(dreamsList[indexPath.row],
        //                                                                  DJDreamsService((UIApplication.shared.delegate as? AppDelegate)?.coreDataService),
        //                                                                  self)
        //        navigationController?.pushViewController(viewController,
        //                                                 animated: true)
    }

    // MARK: - Handlers -
    
    @objc
    private func closeButtonTapped() {
        delegate?.closeScreen()
    }

    @objc
    private func saveButtonTapped() {
        delegate?.saveOpportunity(opportunity)
    }

    // MARK: - Routine -
    
    private func createLayout() {
        view.backgroundColor = .white
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        let closeButton = UIButton(type: .close)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)

        let saveButton = UIButton(type: .contactAdd)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: CloseButtonLeftOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CloseButtonLeftOffset),

            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CloseButtonLeftOffset),
        ])
    }
    
}

