//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Walim Aloui on 14/05/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    
    open override var shouldAutorotate: Bool { return true}
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all}
    
    
}
