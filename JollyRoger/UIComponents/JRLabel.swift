//
//  JRLabel.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

class JRLabel: UIView {

    private let LabelSideOffset: CGFloat = 4
    private let label = UILabel(frame: .zero)
    
    override var intrinsicContentSize: CGSize {
        get {
            var sizeWithInsets = label.intrinsicContentSize
            
            sizeWithInsets.height = ceil(sizeWithInsets.height + 2 * LabelSideOffset)
            sizeWithInsets.width = ceil(sizeWithInsets.width + 2 * LabelSideOffset)
            
            return sizeWithInsets
        }
    }

    public var font: UIFont {
        get {
            return label.font
        }
        set {
            label.font = newValue
        }
    }
    
    public var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    public var textAlignment: NSTextAlignment {
        get {
            return label.textAlignment
        }
        set {
            label.textAlignment = newValue
        }
    }
    
    public var numberOfLines: Int {
        get {
            return label.numberOfLines
        }
        set {
            label.numberOfLines = newValue
        }
    }
    
    init(_ bgColor: UIColor = .clear, _ cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        
        backgroundColor = bgColor
        layer.cornerRadius = cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: LabelSideOffset),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LabelSideOffset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LabelSideOffset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LabelSideOffset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
