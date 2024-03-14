//
//  JRTextField.swift
//  JollyRoger
//
//  Created by cipher on 15.03.2024.
//
import UIKit

class JRTextField: UIView {
    
    private var labelTopConstraint = NSLayoutConstraint()
    private var labelBottomConstraint = NSLayoutConstraint()
    private var labelLeadingConstraint = NSLayoutConstraint()
    private var labelTrailingConstraint = NSLayoutConstraint()
    
    let textField = UITextField(frame: .zero)
    
    override var intrinsicContentSize: CGSize {
        get {
            var sizeWithInsets = textField.intrinsicContentSize
            
            sizeWithInsets.height = ceil(sizeWithInsets.height + abs(edgeInsets.bottom) + abs(edgeInsets.top))
            sizeWithInsets.width = ceil(sizeWithInsets.width + abs(edgeInsets.left) + abs(edgeInsets.right))
            
            return sizeWithInsets
        }
    }
    
    private var _edgeInsets = UIEdgeInsets()
    var edgeInsets:UIEdgeInsets {
        get {
            return _edgeInsets
        }
        set {
            _edgeInsets = newValue
            
            labelLeadingConstraint.constant = _edgeInsets.left
            labelTopConstraint.constant = _edgeInsets.top
            labelBottomConstraint.constant = _edgeInsets.bottom
            labelTrailingConstraint.constant = _edgeInsets.right
            
            setNeedsUpdateConstraints()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        layer.cornerRadius = ceil(intrinsicContentSize.height / 2)
    }
    
    private func createLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        labelTopConstraint = textField.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top)
        labelBottomConstraint = textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom)
        labelLeadingConstraint = textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left)
        labelTrailingConstraint = textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInsets.right)
        NSLayoutConstraint.activate([
            labelTopConstraint,
            labelBottomConstraint,
            labelLeadingConstraint,
            labelTrailingConstraint
        ])
    }
    
}
