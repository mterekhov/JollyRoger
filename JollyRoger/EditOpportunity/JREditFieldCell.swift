//
//  JREditFieldCell.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

typealias EditFieldHandler = (_ newText: String?) -> Void

class JREditFieldCell: UITableViewCell {

    private let TitleFontSize: CGFloat = 24
    private let FontSize: CGFloat = 18
    private let CommonSideOffset: CGFloat = 5

    private let valueTitleLabel = UILabel(frame: .zero)
    private let fieldValueLabel = UILabel(frame: .zero)
    private var changeHandler: EditFieldHandler?

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(_ title: String, _ initialText: String?, _ textChangeHandler: EditFieldHandler?) {
        valueTitleLabel.text = title + ": "
        fieldValueLabel.text = initialText
        changeHandler = textChangeHandler
    }

    private func createLayout() {
        valueTitleLabel.numberOfLines = 1
        valueTitleLabel.font = .etelka(FontSize)
        valueTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        valueTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.addSubview(valueTitleLabel)
        
        fieldValueLabel.numberOfLines = -1
        fieldValueLabel.font = .etelka(FontSize)
        fieldValueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fieldValueLabel)
        
        NSLayoutConstraint.activate([
            valueTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            valueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CommonSideOffset),
            valueTitleLabel.trailingAnchor.constraint(equalTo: fieldValueLabel.leadingAnchor),
            valueTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),

            fieldValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommonSideOffset),
            fieldValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommonSideOffset),
            fieldValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CommonSideOffset),
        ])
    }
    
}