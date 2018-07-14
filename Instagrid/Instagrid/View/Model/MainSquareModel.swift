//
//  UIImage.swift
//  Instagrid
//
//  Created by Walim Aloui on 06/06/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

class MainSquareModel {
    
    // Manages what is included into the picture to send
    func createTheImageToSend(view : MainSquareView) -> UIImage? {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil}
        UIGraphicsEndImageContext()
        return image

    }
}
