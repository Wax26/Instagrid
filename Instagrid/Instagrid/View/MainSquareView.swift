//
//  MainSquareView.swift
//  Instagrid
//
//  Created by Walim Aloui on 04/05/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

class MainSquareView: UIView {
    
    enum SelectedPattern : Int {
        case patternOne
        case patternTwo
        case patternThree
    }
  
   
    var selectedPattern: SelectedPattern = .patternOne
    
    // Outlets
    @IBOutlet var fourSquareUIViewsArray : [UIView]!
    @IBOutlet var plusButtonsArray: [UIButton]!
    @IBOutlet var imageViewsArray : [UIImageView]!
    
    @IBOutlet var imageViewOne : UIImageView!
    @IBOutlet var imageViewTwo : UIImageView!
    @IBOutlet var imageViewThree : UIImageView!
    @IBOutlet var imageViewFour : UIImageView!
    
   
    
        // Functions Setting the chosen pattern into the Main Square
   
    func setFirstPattern() {
        for view in fourSquareUIViewsArray {
            if view.tag == 2 {
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
    
    func checkIfPatternOneIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne.image == nil || imageViewThree.image == nil || imageViewFour.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }
    
    func checkIfPatternTwoIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne.image == nil || imageViewTwo.image == nil || imageViewFour.image == nil {
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
    
    func deleteImages() {
        for images in imageViewsArray {
            images.image = nil
        }
        for plusButton in plusButtonsArray {
            plusButton.isHidden = false
        }
    }
    

    
    func squareViewGoesUp() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.size.height * 2) }, completion : nil)
  
    }
    
    func squareViewGoesLeft() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: -self.frame.size.width * 2, y: 0) }, completion : nil)
    
    

    //    self.frame = CGRect(x: self.frame.origin.x, y: ((superview?.frame.size.height)! / 4) + 7, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func getBackRight() {
        
         self.frame = CGRect(x: ((superview?.frame.size.height)! / 2), y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
    }

    
 
}

