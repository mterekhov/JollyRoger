//
//  JRDatePickerVC.swift
//  JollyRoger
//
//  Created by cipher on 15.03.2024.
//

import UIKit

typealias DateChangedHandler = (_ newDate: Date) -> Void

class JRDatePickerVC: UIViewController {

    private let ContainerViewCornerRadius: CGFloat = 36
    private let ContainerViewWidth: CGFloat = 327
    private let ContainerViewHeightInset: CGFloat = 100
    private let DoneButtonWidth: CGFloat = 122
    private let DoneButtonHeight: CGFloat = 56
    private let DoneButtonOffset: CGFloat = 12
    private let DoneButtonCornerRadius: CGFloat = 40
    private let SpaceBetween: CGFloat = 20

    private let datePicker = UIDatePicker(frame: .zero)

    var dateChangedHandler: DateChangedHandler?
    var doneButtonHandler: VoidCompletionHandler?

    init(initialDate: Date) {
        super.init(nibName: nil, bundle: nil)
        
        datePicker.date = initialDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        createLayout()
    }
    
    private func createLayout() {
        view.backgroundColor = .pirateAlphaBlack()

        let viewContainer = UIView(frame: .zero)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = .white
        viewContainer.layer.cornerRadius = ContainerViewCornerRadius
        view.addSubview(viewContainer)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(datePicker)

        let doneButton = UIButton(frame: .zero)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("OkTitle".local, for: .normal)
        doneButton.addTarget(self, action: #selector(closeDatePicker), for: .touchUpInside)
        doneButton.backgroundColor = .pirateBlue()
        doneButton.layer.cornerRadius = ceil(DoneButtonHeight / 2.0)
        viewContainer.addSubview(doneButton)
        
        var containerHeight = datePicker.intrinsicContentSize.height
        containerHeight += DoneButtonHeight
        containerHeight += 3 * DoneButtonOffset
        containerHeight += ceil(ContainerViewCornerRadius / 2)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: ContainerViewCornerRadius),
            datePicker.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            
            doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: DoneButtonOffset),
            doneButton.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -DoneButtonOffset),
            doneButton.heightAnchor.constraint(equalToConstant: DoneButtonHeight),
            doneButton.widthAnchor.constraint(equalToConstant: DoneButtonWidth),
            
            viewContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            viewContainer.widthAnchor.constraint(equalToConstant: ContainerViewWidth),
            viewContainer.heightAnchor.constraint(equalToConstant: ceil(containerHeight)),
        ])
    }
    
    @objc
    private func closeDatePicker() {
        dateChangedHandler?(datePicker.date)
        doneButtonHandler?()
    }
    
    @objc
    private func dateChanged(datePicker: UIDatePicker) {
        dateChangedHandler?(datePicker.date)
    }
    
}
