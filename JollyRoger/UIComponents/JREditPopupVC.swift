//
//  JREditPopupVC.swift
//  JollyRoger
//
//  Created by cipher on 14.03.2024.
//

import UIKit

typealias OkHandler = (_ newText: String) -> Void
typealias CancelHandler = () -> Void

class JREditPopupVC: UIViewController {
    
    private let BackgroundOpacity: Float = 0.7
    private let BoardTopOffset: CGFloat = 226
    private let BoardSideOffset: CGFloat = 24
    private let BoardHeight: CGFloat = 216
    private let BoardCornerRadius: CGFloat = 36
    
    private let TitleFontSize: CGFloat = 16
    private let OkCancelButtonFontSize: CGFloat = 16
    
    private let ValueTextFieldCornerRadius: CGFloat = 24
    private let ValueTextFieldFontSize: CGFloat = 16
    private let ValueTextFieldTopOffset: CGFloat = 64
    private let ValueTextFieldSideOffset: CGFloat = 12
    private let ValueTextFieldHeight: CGFloat = 64
    
    private let TitleTopOffset: CGFloat = 24
    private let TitleSideOffset: CGFloat = 24
    private let TitleHeight: CGFloat = 20
    
    private let CancelButtonWidth: CGFloat = 122
    private let CancelButtonHeight: CGFloat = 56
    private let CancelButtonLeftOffset: CGFloat = 12
    private let CancelButtonBottomOffset: CGFloat = 12
    private let CancelButtonCornerRadius: CGFloat = 28
    
    private let OkButtonWidth: CGFloat = 76
    private let OkButtonHeight: CGFloat = 56
    private let OkButtonRightOffset: CGFloat = 12
    private let OkButtonBottomOffset: CGFloat = 12
    private let OkButtonCornerRadius: CGFloat = 28
    
    private let TextFieldInsets = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
    
    private let messageBoard = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let valueTextField = JRTextField(frame: .zero)
    private var verticalConstraint = NSLayoutConstraint()
    
    private var okBlock:OkHandler?
    private var cancelBlock:CancelHandler?

    init(initialValue: String, title: String, okBlock: @escaping OkHandler, cancelBlock: @escaping CancelHandler) {
        self.valueTextField.textField.text = initialValue
        self.titleLabel.text = title
        self.okBlock = okBlock
        self.cancelBlock = cancelBlock
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        createLayout()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Routine -
    
    private func createLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = BackgroundOpacity

        messageBoard.translatesAutoresizingMaskIntoConstraints = false
        messageBoard.layer.cornerRadius = BoardCornerRadius
        messageBoard.backgroundColor = .white
        view.addSubview(messageBoard)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.font = .etelka(TitleFontSize)
        titleLabel.textColor = .pirateAlto()
        titleLabel.numberOfLines = 0
        messageBoard.addSubview(titleLabel)
        
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.textField.font = .etelka(ValueTextFieldFontSize)
        valueTextField.textField.textColor = .black
        valueTextField.textField.autocorrectionType = .no
        valueTextField.backgroundColor = .pirateAlto()
        valueTextField.layer.cornerRadius = ValueTextFieldCornerRadius
        valueTextField.edgeInsets = TextFieldInsets
        messageBoard.addSubview(valueTextField)
        
        let cancelButton = UIButton(frame: .zero)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("CancelTitle".local, for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .etelka(OkCancelButtonFontSize)
        cancelButton.backgroundColor = .pirateAlto()
        cancelButton.layer.cornerRadius = CancelButtonCornerRadius
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        messageBoard.addSubview(cancelButton)
        
        let okButton = UIButton(frame: .zero)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("OkTitle".local, for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font = .etelka(OkCancelButtonFontSize)
        okButton.backgroundColor = .pirateBlue()
        okButton.layer.cornerRadius = OkButtonCornerRadius
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        messageBoard.addSubview(okButton)
        
        verticalConstraint = messageBoard.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        NSLayoutConstraint.activate([
            verticalConstraint ,
            messageBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BoardSideOffset),
            messageBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BoardSideOffset),
            messageBoard.heightAnchor.constraint(equalToConstant: calculateMessageBoardHeight()),
            
            titleLabel.topAnchor.constraint(equalTo: messageBoard.topAnchor, constant: TitleTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: messageBoard.leadingAnchor, constant: TitleSideOffset),
            titleLabel.trailingAnchor.constraint(equalTo: messageBoard.trailingAnchor, constant: -TitleSideOffset),
            
            valueTextField.leadingAnchor.constraint(equalTo: messageBoard.leadingAnchor, constant: ValueTextFieldSideOffset),
            valueTextField.trailingAnchor.constraint(equalTo: messageBoard.trailingAnchor, constant: -ValueTextFieldSideOffset),
            valueTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: TitleSideOffset),
            valueTextField.heightAnchor.constraint(equalToConstant: ValueTextFieldHeight),
            
            okButton.widthAnchor.constraint(equalToConstant: OkButtonWidth),
            okButton.heightAnchor.constraint(equalToConstant: OkButtonHeight),
            okButton.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: OkButtonBottomOffset),
            okButton.trailingAnchor.constraint(equalTo: messageBoard.trailingAnchor, constant: -OkButtonRightOffset),
            
            cancelButton.widthAnchor.constraint(equalToConstant: CancelButtonWidth),
            cancelButton.heightAnchor.constraint(equalToConstant: CancelButtonHeight),
            cancelButton.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: CancelButtonBottomOffset),
            cancelButton.leadingAnchor.constraint(equalTo: messageBoard.leadingAnchor, constant: CancelButtonLeftOffset),
        ])
    }
    
    private func calculateMessageBoardHeight() -> CGFloat {
        var labelFitSize = view.bounds.size
        labelFitSize.width -= 2 * BoardSideOffset + 2 * TitleTopOffset
        
        var messageBoardHeight: CGFloat = titleLabel.sizeThatFits(labelFitSize).height
        messageBoardHeight += ValueTextFieldHeight
        messageBoardHeight += OkButtonHeight
        messageBoardHeight += TitleTopOffset
        messageBoardHeight += TitleTopOffset
        messageBoardHeight += OkButtonBottomOffset
        messageBoardHeight += OkButtonCornerRadius / 2
        
        return ceil(messageBoardHeight)
    }
    
    // MARK: - Handlers -
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        view.removeConstraint(verticalConstraint)
        verticalConstraint = messageBoard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardSize.height - BoardSideOffset)
        verticalConstraint.isActive = true
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        view.removeConstraint(verticalConstraint)
        verticalConstraint = messageBoard.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        verticalConstraint.isActive = true
    }
    
    @objc
    private func cancelButtonTapped() {
        guard let cancelBlock = cancelBlock else {
            return
        }
        
        cancelBlock()
    }
    
    @objc
    private func okButtonTapped() {
        guard let okBlock = okBlock else {
            return
        }
        
        okBlock(valueTextField.textField.text ?? "")
    }
    
}
