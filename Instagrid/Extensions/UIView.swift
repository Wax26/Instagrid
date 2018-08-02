//
//  UIView.swift
//  Instagrid
//
//  Created by Walim on 30/07/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.


import UIKit

extension UIView {
    
    func convertToUIImage() -> UIImage? {
        
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil}
        UIGraphicsEndImageContext()
        return image
    }
}
