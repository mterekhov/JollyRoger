//
//  JRButton.swift
//  JollyRoger
//
//  Created by cipher on 16.03.2024.
//

import UIKit

class JRButton: UIView {
    
    private let BorderWidth: CGFloat = 1
    
    private let titleLabel = UILabel(frame: .zero)

    var textColor:UIColor {
        get {
            return titleLabel.textColor
        }
        
        set {
            titleLabel.textColor = newValue
        }
    }
    
    var font:UIFont {
        get {
            return titleLabel.font
        }
        
        set {
            titleLabel.font = newValue
        }
    }
    
    var title:String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    init(frame: CGRect, buttonHeight: CGFloat, target:Any, action: Selector) {
        super.init(frame: frame)
        
        createLayout(buttonHeight: buttonHeight, target:target, action:action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLayout(buttonHeight: CGFloat, target: Any, action: Selector) {
        backgroundColor = .clear
        layer.cornerRadius = ceil(buttonHeight / 2)
        layer.borderWidth = BorderWidth

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.isUserInteractionEnabled = false
        addSubview(titleLabel)
        
        let gestureView = UIView(frame: .zero)
        gestureView.backgroundColor = .clear
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        gestureView.addGestureRecognizer(tapGesture)
        addSubview(gestureView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            gestureView.topAnchor.constraint(equalTo: topAnchor),
            gestureView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gestureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gestureView.trailingAnchor.constraint(equalTo:trailingAnchor)
        ])
    }
    
}
