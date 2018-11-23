//
//  ViewController+Background.swift
//  Instagrid
//
//  Created by Walim Aloui on 22/08/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import Foundation


extension ViewController {
    
    // Happens when pattern is complete
    func manageBackGroundColor() {
        if mainSquareView.checkIfZoneIsFullWithImage() {
            self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            self.view.backgroundColor = #colorLiteral(red: 0.6857407689, green: 0.847186029, blue: 0.9051745534, alpha: 1)
        }
    }
}
