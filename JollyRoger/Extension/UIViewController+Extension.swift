//
//  UIViewController+Extension.swift
//  JollyRoger
//
//  Created by cipher on 15.03.2024.
//
import UIKit

extension UIViewController {

    func jollyroger_presentModal(viewControllerToPresent: UIViewController) {
        addChild(viewControllerToPresent)
        view.addSubview(viewControllerToPresent.view)
        
        NSLayoutConstraint.activate([
            viewControllerToPresent.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewControllerToPresent.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewControllerToPresent.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewControllerToPresent.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func jollyroger_dismissModal() {
        guard let _ = view.superview else {
            return
        }
        view.removeFromSuperview()
        
        guard let _ = parent else {
            return
        }
        removeFromParent()
    }
    
}
