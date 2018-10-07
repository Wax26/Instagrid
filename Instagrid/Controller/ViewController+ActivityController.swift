//
//  ViewController+ActivityController.swift
//  Instagrid
//
//  Created by Walim Aloui on 22/08/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import Foundation
import UIKit 

extension ViewController  {
    // Here has to be added the image file to provide
    
    func presentActivityController() {
        
        guard let image = mainSquareView.convertToUIImage() else {
            return}
        let activityViewController = UIActivityViewController( activityItems: [image],applicationActivities: nil)
        // activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if(UIDevice.current.orientation.isPortrait){
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.mainSquareView.transform = .identity
                }, completion:nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.mainSquareView.transform = .identity
                }, completion:nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}
