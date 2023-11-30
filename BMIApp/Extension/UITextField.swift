//
//  UITextField.swift
//  BMIApp
//
//  Created by 예찬 on 11/30/23.
//

import UIKit

extension UITextField {
    
    // 키보드 위에 툴바 추가하는 메서드
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                            target: onDone.target,
                            action: onDone.action),
            UIBarButtonItem(title: "Done",
                            style: .done,
                            target: onDone.target,
                            action: onDone.action)
        ]
        
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { resignFirstResponder() }
}
