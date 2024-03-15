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

    private let positionTitleLabel = JRLabel(.clear, LabelCornerRadius)
    private let dateLabel = JRLabel(.clear, LabelCornerRadius)
    private let companyNameLabel = JRLabel(.clear, LabelCornerRadius)
    private let salaryLabel = JRLabel(.clear, LabelCornerRadius)
    private let statusIndicatorView = UIView(frame: .zero)

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(_ newOpportunity: JROpportunity) {
        positionTitleLabel.text = newOpportunity.positionTitle
        dateLabel.text = DateFormatter.jollyroger_dateFormatter().string(from: newOpportunity.date)
        companyNameLabel.text = ">>> "
        companyNameLabel.text?.append(newOpportunity.companyName)
        
        salaryLabel.text = newOpportunity.salary
        
        switch newOpportunity.status {
        case .closedAsFailed, .closedAsOffer:
            statusIndicatorView.backgroundColor = newOpportunity.status.color
        default:
            statusIndicatorView.backgroundColor = .clear
        }
    }

    private func createLayout() {
        positionTitleLabel.numberOfLines = 1
        positionTitleLabel.font = .etelka(PositionFontSize)
        contentView.addSubview(positionTitleLabel)
        
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

        statusIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        statusIndicatorView.backgroundColor = .clear
        contentView.addSubview(statusIndicatorView)
        
        NSLayoutConstraint.activate([
            statusIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            statusIndicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            statusIndicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statusIndicatorView.widthAnchor.constraint(equalToConstant: CommonSideOffset),

            positionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            positionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CommonSideOffset),

            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            dateLabel.leadingAnchor.constraint(equalTo: positionTitleLabel.trailingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CommonSideOffset),

            companyNameLabel.topAnchor.constraint(equalTo: positionTitleLabel.bottomAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CommonSideOffset),
            companyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),

            salaryLabel.topAnchor.constraint(equalTo: positionTitleLabel.bottomAnchor),
            salaryLabel.leadingAnchor.constraint(equalTo: companyNameLabel.trailingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CommonSideOffset),
            salaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),
        ])
    }
    
}
