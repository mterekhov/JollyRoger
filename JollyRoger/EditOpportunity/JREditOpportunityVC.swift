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
    case remoteStatus
    case notes

    case size
    
}

protocol JREditOpportunityDelegate: AnyObject {
    
    func saveOpportunity(_ opportunityValue: JROpportunity)
    func closeScreen()

}

class JREditOpportunityVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let PositionFontSize: CGFloat = 24
    private let TopButtonFontSize: CGFloat = 12
    private let TopButtonWidth: CGFloat = 60
    private let TopButtonHeight: CGFloat = 32

    private let CloseButtonLeftOffset: CGFloat = 25

    private var opportunity: JROpportunity
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let positionTitleLabel = UILabel(frame: .zero)
    
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
        return EOpportunityField.size.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = JREditFieldCell(frame: .zero)
        newCell.backgroundColor = .cyan
        
        let field = EOpportunityField(rawValue: indexPath.row)
        switch field {
        case .positionTitle:
            let expCell = JRCommonCell(frame: .zero)
            expCell.selectionStyle = .none
            expCell.configureCell(opportunity)
            expCell.editSalaryBlock = {
                let editVC = JREditPopupVC()
                let cancelBlock: CancelHandler = {
                    self.tableView.reloadData()
                    editVC.jollyroger_dismissModal()
                }
                editVC.configure(initialValue: self.opportunity.salary,
                                 title: "Edit",
                                 okBlock: { newText in
                    self.opportunity.salary = newText
                    self.tableView.reloadData()
                    editVC.jollyroger_dismissModal()
                },
                                 cancelBlock: cancelBlock)
                self.jollyroger_presentModal(viewControllerToPresent: editVC)
            }
            expCell.editStatusBlock = {
                let editVC = JREditPopupVC()
                let cancelBlock: CancelHandler = {
                    self.tableView.reloadData()
                    editVC.jollyroger_dismissModal()
                }
                let statusPickerVC = JRStatusPickerVC(title: "Status".local, limit: 4, initialValue: self.opportunity.status.rawValue)
                statusPickerVC.doneButtonHandler = {
                    statusPickerVC.jollyroger_dismissModal()
                    self.tableView.reloadData()
                }
                statusPickerVC.statusChangedHandler = { newStatus in
                    self.opportunity.status = newStatus
                }
                self.jollyroger_presentModal(viewControllerToPresent: statusPickerVC)
            }
            expCell.editDateBlock = {
                let editVC = JREditPopupVC()
                let cancelBlock: CancelHandler = {
                    self.tableView.reloadData()
                    editVC.jollyroger_dismissModal()
                }
                let datePickerVC = JRDatePickerVC(initialDate: self.opportunity.date)
                datePickerVC.doneButtonHandler = {
                    datePickerVC.jollyroger_dismissModal()
                    self.tableView.reloadData()
                }
                datePickerVC.dateChangedHandler = { newDate in
                    self.opportunity.date = newDate
                }
                self.jollyroger_presentModal(viewControllerToPresent: datePickerVC)
            }
            return expCell
        case .companyName:
            newCell.configureCell("Company", opportunity.companyName)
        case .contactName:
            newCell.configureCell("Contact", opportunity.contactName)
        case .contactPoint:
            newCell.configureCell("Contact point", opportunity.contactPoint)
        case .remoteStatus:
            newCell.configureCell("Remote", opportunity.remoteStatus)
        case .notes:
            newCell.configureCell("Notes", opportunity.notes)
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
        switch indexPath.row {
        case EOpportunityField.notes.rawValue:
            return UITableView.automaticDimension
        default:
            return 60
        }
    }

    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = EOpportunityField(rawValue: indexPath.row)

        let editVC = JREditPopupVC()
        let cancelBlock: CancelHandler = {
            self.tableView.reloadData()
            editVC.jollyroger_dismissModal()
        }
        switch field {
        case .companyName:
            editVC.configure(initialValue: opportunity.companyName,
                             title: "Edit",
                             okBlock: { newText in
                self.opportunity.companyName = newText
                self.tableView.reloadData()
                editVC.jollyroger_dismissModal()
            },
                             cancelBlock: cancelBlock)
            jollyroger_presentModal(viewControllerToPresent: editVC)
        case .contactName:
            editVC.configure(initialValue: opportunity.contactName,
                             title: "Edit",
                             okBlock: { newText in
                self.opportunity.contactName = newText
                self.tableView.reloadData()
                editVC.jollyroger_dismissModal()
            },
                             cancelBlock: cancelBlock)
            jollyroger_presentModal(viewControllerToPresent: editVC)
        case .contactPoint:
            editVC.configure(initialValue: opportunity.contactPoint,
                             title: "Edit",
                             okBlock: { newText in
                self.opportunity.contactPoint = newText
                self.tableView.reloadData()
                editVC.jollyroger_dismissModal()
            },
                             cancelBlock: cancelBlock)
            jollyroger_presentModal(viewControllerToPresent: editVC)
        case .notes:
            editVC.configure(initialValue: opportunity.notes,
                             title: "Edit",
                             okBlock: { newText in
                self.opportunity.notes = newText
                self.tableView.reloadData()
                editVC.jollyroger_dismissModal()
            },
                             cancelBlock: cancelBlock)
            jollyroger_presentModal(viewControllerToPresent: editVC)
        case .remoteStatus:
            editVC.configure(initialValue: opportunity.remoteStatus,
                             title: "Edit",
                             okBlock: { newText in
                self.opportunity.remoteStatus = newText
                self.tableView.reloadData()
                editVC.jollyroger_dismissModal()
            },
                             cancelBlock: cancelBlock)
            jollyroger_presentModal(viewControllerToPresent: editVC)
        default:
            break
        }
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
        
        positionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        positionTitleLabel.font = .etelka(PositionFontSize)
        positionTitleLabel.text = opportunity.positionTitle
        view.addSubview(positionTitleLabel)

        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        let closeButton = JRButton(frame: .zero, buttonHeight: TopButtonHeight, target: self, action: #selector(closeButtonTapped))
        closeButton.font = .etelka(TopButtonFontSize)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.title = "CloseButtonTitle".local
        view.addSubview(closeButton)

        let saveButton = JRButton(frame: .zero, buttonHeight: TopButtonHeight, target: self, action: #selector(saveButtonTapped))
        saveButton.font = .etelka(TopButtonFontSize)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.title = "SaveButtonTitle".local
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            positionTitleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: CloseButtonLeftOffset),
            positionTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CloseButtonLeftOffset),

            tableView.topAnchor.constraint(equalTo: positionTitleLabel.bottomAnchor, constant: CloseButtonLeftOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CloseButtonLeftOffset),
            closeButton.widthAnchor.constraint(equalToConstant: TopButtonWidth),
            closeButton.heightAnchor.constraint(equalToConstant: TopButtonHeight),

            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CloseButtonLeftOffset),
            saveButton.widthAnchor.constraint(equalToConstant: TopButtonWidth),
            saveButton.heightAnchor.constraint(equalToConstant: TopButtonHeight)
        ])
    }
    
}

