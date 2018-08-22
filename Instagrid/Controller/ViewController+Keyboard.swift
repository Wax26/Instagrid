//
//  ViewController+Location.swift
//  Instagrid
//
//  Created by Walim Aloui on 22/08/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    fileprivate  func hideKeyboard() {
        locationTextField.resignFirstResponder()
    }
    
    @objc  func keyboardWillChange(notification : Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
}
