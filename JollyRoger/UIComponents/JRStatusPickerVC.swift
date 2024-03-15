//
//  JRStatusPickerVC.swift
//  JollyRoger
//
//  Created by cipher on 15.03.2024.
//
import UIKit

typealias StatusChangedHandler = (_ newStatus: EOpportunityStatus) -> Void
typealias VoidCompletionHandler = () -> Void

class JRStatusPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let HeaderTitleFontSize:CGFloat = 17
    
    private let ContainerViewCornerRadius:CGFloat = 36
    private let ContainerViewWidth:CGFloat = 327
    private let ContainerViewHeightInset:CGFloat = 100
    private let DoneButtonWidth:CGFloat = 122
    private let DoneButtonHeight:CGFloat = 56
    private let DoneButtonOffset:CGFloat = 12
    private let DoneButtonCornerRadius:CGFloat = 40
    private let SpaceBetween:CGFloat = 20
    
    private let titleLabel = UILabel(frame: .zero)
    private let pickerView = UIPickerView(frame: .zero)

    private let initialValue: Int
    private let limit: Int
    
    var statusChangedHandler: StatusChangedHandler?
    var doneButtonHandler: VoidCompletionHandler?

    init(title: String, limit: Int, initialValue: Int) {
        self.initialValue = initialValue
        self.limit = limit
        
        super.init(nibName: nil, bundle: nil)
        
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        createLayout()
    }
    
    // MARK: - Routine -
    
    private func createLayout() {
        view.backgroundColor = .pirateAlphaBlack()
        
        let viewContainer = UIView(frame: .zero)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = .white
        viewContainer.layer.cornerRadius = ContainerViewCornerRadius
        
        let doneButton = UIButton(frame: .zero)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("OkTitle".local, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.backgroundColor = .pirateBlue()
        doneButton.layer.cornerRadius = ceil(DoneButtonHeight / 2.0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = .etelka(HeaderTitleFontSize)
        titleLabel.textAlignment = .center
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.selectRow(Int(initialValue), inComponent: 0, animated: false)

        viewContainer.addSubview(pickerView)
        viewContainer.addSubview(doneButton)
        viewContainer.addSubview(titleLabel)
        view.addSubview(viewContainer)
        
        var labelFitSize = view.bounds.size
        labelFitSize.width = ContainerViewWidth - 4 * DoneButtonOffset
        
        var containerHeight = pickerView.intrinsicContentSize.height
        containerHeight += DoneButtonHeight
        containerHeight += titleLabel.sizeThatFits(labelFitSize).height
        containerHeight += 3 * ContainerViewCornerRadius
        containerHeight += ceil(ContainerViewCornerRadius / 2)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: ContainerViewCornerRadius),
            titleLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 2 * DoneButtonOffset),
            titleLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -2 * DoneButtonOffset),
            
            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ContainerViewCornerRadius),
            pickerView.heightAnchor.constraint(equalToConstant: pickerView.intrinsicContentSize.height),
            pickerView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            
            doneButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: ContainerViewCornerRadius),
            doneButton.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -DoneButtonOffset),
            doneButton.heightAnchor.constraint(equalToConstant: DoneButtonHeight),
            doneButton.widthAnchor.constraint(equalToConstant: DoneButtonWidth),
            
            viewContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            viewContainer.widthAnchor.constraint(equalToConstant: ContainerViewWidth),
            viewContainer.heightAnchor.constraint(equalToConstant: ceil(containerHeight)),
        ])
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        pickerView.selectRow(Int(initialValue), inComponent: 0, animated: true)
//        pickerView.reloadAllComponents()
//
//    }
    
    // MARK: - Handler -
    
    @objc
    private func doneButtonTapped(_ button: UIButton) {
        statusChangedHandler?(EOpportunityStatus(rawValue: pickerView.selectedRow(inComponent: 0)) ?? .inProgress)
        doneButtonHandler?()
    }
    
    // MARK: - UIPickerViewDataSource -
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return limit
    }
    
    // MARK: - UIPickerViewDelegate -
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        switch row {
        case 0, 1, 2, 3:
            let status = EOpportunityStatus(rawValue: row)
            return status?.title
        default:
            break
        }
        
        return "StatusUnknown".local
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusChangedHandler?(EOpportunityStatus(rawValue: row) ?? .inProgress)
    }
    
}
