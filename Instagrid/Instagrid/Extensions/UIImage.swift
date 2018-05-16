//
//  UIImage.swift
//  Instagrid
//
//  Created by Walim Aloui on 16/05/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

extension UIImage {
    
        convenience init(view: UIView) {
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.init(cgImage: image!.cgImage!)
        }
    }

