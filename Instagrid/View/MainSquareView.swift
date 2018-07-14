//
//  MainSquareView.swift
//  Instagrid
//
//  Created by Walim Aloui on 04/05/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

class MainSquareView: UIView {
    
    
    // MARK: Pattern Enumeration and variable
    enum SelectedPattern : Int {
        case patternOne
        case patternTwo
        case patternThree
    }
    var selectedPattern: SelectedPattern = .patternOne
    
    // MARK: Outlets Arrays
    @IBOutlet var fourSquareUIViewsArray : [UIView]!
    @IBOutlet var plusButtonsArray: [UIButton]!
    @IBOutlet var imageViewsArray : [UIImageView]!
    
    // MARK: Separated views Outlets
    @IBOutlet var imageViewOne : UIImageView!
    @IBOutlet var imageViewTwo : UIImageView!
    @IBOutlet var imageViewThree : UIImageView!
    @IBOutlet var imageViewFour : UIImageView!
    
   
    
    
    // MARK: Functions to set the patterns
    // Functions Setting the chosen pattern into the Main Square
    func setFirstPattern() {
        for view in fourSquareUIViewsArray {
            if view.tag == 0 {
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
    }
    
    func setSecondPattern() {
        for view in fourSquareUIViewsArray {
            if view.tag == 3 {
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
    }
    
    func setThirdPattern() {
        for image in fourSquareUIViewsArray {
            image.isHidden = false
        }
    }
    
    
    
    
    
    // MARK: Functions to check fullness of the related patterns
    func checkIfPatternIsEmpty() -> Bool {
        var patternIsEmpty : Bool = false
        switch selectedPattern {
        case .patternOne :
            if imageViewTwo.image == nil && imageViewThree.image == nil && imageViewFour.image == nil {
                patternIsEmpty = true
            } else {
                patternIsEmpty = false
            }
            return patternIsEmpty
            
        case .patternTwo :
            if imageViewOne.image == nil && imageViewTwo.image == nil && imageViewThree.image == nil {
                patternIsEmpty = true
            } else {
                patternIsEmpty = false
            }
            return patternIsEmpty
            
        case .patternThree :
            if imageViewOne.image == nil && imageViewTwo.image == nil && imageViewThree == nil && imageViewFour == nil {
                patternIsEmpty = true
            } else {
                patternIsEmpty = false
            }
            return patternIsEmpty
        }
        
    }
    
    func checkIfPatternOneIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewTwo.image == nil || imageViewThree.image == nil || imageViewFour.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }
    
    func checkIfPatternTwoIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne.image == nil || imageViewTwo.image == nil || imageViewThree.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }
    
    func checkIfPatternThreeIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne.image == nil || imageViewTwo.image == nil || imageViewThree.image == nil || imageViewFour.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }

    func checkIfZoneIsFullWithImage() -> Bool {
        var allViewsAreFull : Bool = false
        switch selectedPattern {
        case .patternOne :
            
            if checkIfPatternOneIsTruelyFull() {
                allViewsAreFull = true
            } else {
                allViewsAreFull = false
            }
            
        case .patternTwo :
            if checkIfPatternTwoIsTruelyFull(){
                allViewsAreFull = true
            } else {
                allViewsAreFull = false
            }
            
        case .patternThree :
            if checkIfPatternThreeIsTruelyFull() {
                allViewsAreFull = true
                
            } else {
                allViewsAreFull = false
            }
        }
        return allViewsAreFull
    }
    
    
    // MARK: Deleting images managament
    func deleteImages() {
        for images in imageViewsArray {
            images.image = nil
        }
        for plusButton in plusButtonsArray {
            plusButton.isHidden = false
        }
    }
    
    
    // MARK: Animation functions
    func squareViewGoesUp() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.size.height * 2) }, completion : nil)
  
    }
    
    func squareViewGoesLeft() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: -self.frame.size.width * 2, y: 0) }, completion : nil)
    
    

   
    }

}

