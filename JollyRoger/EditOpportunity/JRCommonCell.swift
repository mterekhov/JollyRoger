//
//  JRCommonCell.swift
//  JollyRoger
//
//  Created by cipher on 16.03.2024.
//

import UIKit

typealias ValueChangedHandler = (_ newText: String) -> Void

class JRCommonCell: UITableViewCell {

    private let FontSize: CGFloat = 12
    private let CommonSideOffset: CGFloat = 10

    private let salaryLabel = UILabel(frame: .zero)
    private let dateLabel = UILabel(frame: .zero)
    private let statusLabel = UILabel(frame: .zero)

    var editSalaryBlock: VoidCompletionHandler?
    var editStatusBlock: VoidCompletionHandler?
    var editDateBlock: VoidCompletionHandler?

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(_ opportunity: JROpportunity) {
        salaryLabel.text = opportunity.salary
        statusLabel.text = opportunity.status.title
        dateLabel.text = DateFormatter.jollyroger_dateFormatter().string(from: opportunity.date)
    }

    @objc
    private func editSalaryTapped() {
        print("editSalaryTapped")
        editSalaryBlock?()
    }
    
    @objc
    private func editStatusTapped() {
        print("editStatusTapped")
        editStatusBlock?()
    }
    
    @objc
    private func editDateTapped() {
        print("editDateTapped")
        editDateBlock?()
    }
    
    private func createLayout() {
        salaryLabel.font = .etelka(FontSize)
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryLabel.textAlignment = .center
        contentView.addSubview(salaryLabel)
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(editSalaryTapped))
        tapGesture.cancelsTouchesInView = true
        salaryLabel.addGestureRecognizer(tapGesture)
        contentView.addSubview(salaryLabel)

        statusLabel.font = .etelka(FontSize)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .center

        let labelContainer = UIView(frame: .zero)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.addSubview(statusLabel)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(editStatusTapped))
        tapGesture.cancelsTouchesInView = true
        labelContainer.addGestureRecognizer(tapGesture)
        contentView.addSubview(labelContainer)

        dateLabel.font = .etelka(FontSize)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(editDateTapped))
        tapGesture.cancelsTouchesInView = true
        dateLabel.addGestureRecognizer(tapGesture)
        
        let width: CGFloat = ceil(bounds.width / 3.0)

        NSLayoutConstraint.activate([
            salaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            salaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            salaryLabel.widthAnchor.constraint(equalToConstant: width),

            statusLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor),

            labelContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelContainer.widthAnchor.constraint(equalToConstant: width),

            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: width),
        ])
    }
    
}
