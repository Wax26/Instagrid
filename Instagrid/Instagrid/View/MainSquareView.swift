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
    @IBOutlet var imageViewOne : UIImageView?
    @IBOutlet var imageViewTwo : UIImageView?
    @IBOutlet var imageViewThree : UIImageView?
    @IBOutlet var imageViewFour : UIImageView?
    
    
    
    // Functions Setting the chosen pattern into the Main Square
    func setDefaultPattern() {
        
        for view in fourSquareUIViewsArray {
            if view.tag == 2 { 
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
    }
    
    
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
        for view in fourSquareUIViewsArray {
            view.isHidden = false
        }
    }
    
    func checkIfPatternOneIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne!.image == nil || imageViewThree!.image == nil || imageViewFour!.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }
    
    func checkIfPatternTwoIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne!.image == nil || imageViewTwo!.image == nil || imageViewFour!.image == nil {
            patternIsFull = false
        } else {
            patternIsFull = true
        }
        return patternIsFull
    }
    
    func checkIfPatternThreeIsTruelyFull() -> Bool {
        var patternIsFull : Bool = false
        if imageViewOne!.image == nil || imageViewTwo!.image == nil || imageViewThree!.image == nil || imageViewFour!.image == nil {
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
    
    func goUp() {
        self.frame = CGRect(x: self.frame.origin.x, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        
    }
    
    /*
     for _ in mainImageViewZones {
     if pattern == .patternOne {
     if (taggedOneView as? UIImageView)?.image == nil || (taggedFiveView as? UIImageView)?.image == nil || (taggedSixView as? UIImageView)?.image == nil {
     allViewsAreFull = false
     } else {
     allViewsAreFull = true
     }
     } else if pattern == .patternTwo {
     if (taggedThreeView as? UIImageView)?.image == nil || (taggedFourView as? UIImageView)?.image == nil ||
     (taggedTwoView as? UIImageView)?.image == nil {
     allViewsAreFull = false
     } else {
     allViewsAreFull = true
     }
     } else if pattern == .patternThree {
     if (taggedThreeView as? UIImageView)?.image == nil || (taggedFourView as? UIImageView)?.image == nil ||
     (taggedFiveView as? UIImageView)?.image == nil || (taggedSixView as? UIImageView)?.image == nil {
     allViewsAreFull = false
     
     } else {
     allViewsAreFull = true
     }
     }
     }
     return allViewsAreFull
     }
     */
    
    /*
     fileprivate func manageUpperHalfViews() {
     if (taggedThreeView as! UIImageView).image == nil && (taggedOneView as! UIImageView).image != nil   {
     (taggedThreeView as! UIImageView).image = (taggedOneView as! UIImageView).image
     taggedThreeView.subviews[0].isHidden = true
     
     }
     if (taggedOneView as! UIImageView).image == nil && (taggedThreeView as! UIImageView).image != nil {
     (taggedOneView as! UIImageView).image = (taggedThreeView as! UIImageView).image
     taggedOneView.subviews[0].isHidden = true
     }
     }
     
     fileprivate func manageDownerHalfViews() {
     if (taggedTwoView as! UIImageView).image == nil && (taggedSixView as! UIImageView).image != nil {
     (taggedTwoView as! UIImageView).image = (taggedSixView as! UIImageView).image
     taggedTwoView.subviews[0].isHidden = true
     }
     if (taggedSixView as! UIImageView).image == nil && (taggedTwoView as! UIImageView).image != nil {
     (taggedSixView as! UIImageView).image = (taggedTwoView as! UIImageView).image
     taggedSixView.subviews[0].isHidden = true
     }
     }
     
     func managePatternChanges() {
     manageUpperHalfViews()
     manageDownerHalfViews()
     }
     
     
     
     
     }
     
     extension UIImage {
     convenience init(view: UIView) {
     UIGraphicsBeginImageContext(view.frame.size)
     view.layer.render(in:UIGraphicsGetCurrentContext()!)
     let image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     self.init(cgImage: image!.cgImage!)
     }*/
}






