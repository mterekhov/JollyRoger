//
//  JROpportunityCell.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

fileprivate let CounterSize: CGFloat = 20
fileprivate let LabelCornerRadius: CGFloat = 0
fileprivate let CommonSideOffset: CGFloat = 10
fileprivate let FontSize: CGFloat = 12
fileprivate let PositionFontSize: CGFloat = 18

class JROpportunityCell: UITableViewCell {

    private let poisitionTitleLabel = JRLabel(.clear, LabelCornerRadius)
    private let dateLabel = JRLabel(.clear, LabelCornerRadius)
    private let companyNameLabel = JRLabel(.clear, LabelCornerRadius)
    private let salaryLabel = JRLabel(.clear, LabelCornerRadius)

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(_ newOpportunity: JROpportunity) {
        poisitionTitleLabel.text = newOpportunity.positionTitle
        dateLabel.text = DateFormatter.jollyroger_dateFormatter().string(from: newOpportunity.date)
        companyNameLabel.text = ">>> "
        companyNameLabel.text?.append(newOpportunity.companyName)
        
        salaryLabel.text = newOpportunity.salary
        contentView.backgroundColor = newOpportunity.status.color
    }

    private func createLayout() {
        poisitionTitleLabel.numberOfLines = 1
        poisitionTitleLabel.font = .etelka(PositionFontSize)
        contentView.addSubview(poisitionTitleLabel)
        
        dateLabel.numberOfLines = 1
        dateLabel.font = .etelka(FontSize)
        dateLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.addSubview(dateLabel)

        companyNameLabel.numberOfLines = 1
        companyNameLabel.font = .etelka(FontSize)
        contentView.addSubview(companyNameLabel)

        salaryLabel.numberOfLines = 1
        salaryLabel.font = .etelka(FontSize)
        salaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        salaryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.addSubview(salaryLabel)

        NSLayoutConstraint.activate([
            poisitionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            poisitionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CommonSideOffset),

            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            dateLabel.leadingAnchor.constraint(equalTo: poisitionTitleLabel.trailingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CommonSideOffset),

            companyNameLabel.topAnchor.constraint(equalTo: poisitionTitleLabel.bottomAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CommonSideOffset),
            companyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),

            salaryLabel.topAnchor.constraint(equalTo: poisitionTitleLabel.bottomAnchor),
            salaryLabel.leadingAnchor.constraint(equalTo: companyNameLabel.trailingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CommonSideOffset),
            salaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),
        ])
    }
    
}
