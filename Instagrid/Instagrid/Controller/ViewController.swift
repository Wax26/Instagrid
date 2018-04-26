//
//  ViewController.swift
//  Instagrid
//
//  Created by Walim Aloui on 27/03/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var arrayComparingTags = [Int]()
    // The three model buttons outlets
    @IBOutlet weak var modelOneButtonOutlet: UIButton!
    @IBOutlet weak var modelTwoButtonOutlet: UIButton!
    @IBOutlet weak var modelThreeButtonOutlet: UIButton!
    
    // The "Instagrid" Label
    @IBOutlet weak var swipeLabel: UILabel!
    
    
    // The different squares of the main view
    
    @IBOutlet var mainViewZones: [UIImageView]!
    
    @IBOutlet weak var mainSquare: UIView!
    
    
    
    @IBOutlet var plusButtons: [UIButton]!
    
    
    
    
    func findTagOfZone(button : UIButton) -> Int {
        var result = 0
        for zone in mainViewZones {
            let tagZone = zone.tag
            if tagZone == button.tag{
                result = tagZone
            }
        }
        return result
    }
    
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
            var buttonTag = sender.tag
            arrayComparingTags.insert(buttonTag, at: 0)
            print(buttonTag)
            print(arrayComparingTags)
            var tappedNumberOfTimes = 0
            tappedNumberOfTimes += 1
            if tappedNumberOfTimes > 1 {
                tappedNumberOfTimes = 0
            }
            print(tappedNumberOfTimes)
            
        }
    }
    /*
     
     if UIImagePickerController.isSourceTypeAvailable(.camera) {
     var imagePicker = UIImagePickerController()
     imagePicker.delegate = self
     imagePicker.sourceType = .camera;
     imagePicker.allowsEditing = false
     self.present(imagePicker, animated: true, completion: nil)
     } */
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        for aButton in plusButtons {
            for aView in mainViewZones {
                if  arrayComparingTags[0] == aView.tag && arrayComparingTags[0] == aButton.tag {
                    aView.image = image
                    checkIfImageIsLoaded(aView, button: aButton)
                }
                
            }
            
            dismiss(animated:true, completion: nil)
            
        }
        
    }
    
    
    
    func checkIfImageIsLoaded(_ area : UIImageView, button : UIButton) {
        if area.image == nil {
            button.isHidden = false
        } else {
            button.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // We set the default pattern
        for zone in mainViewZones {
            if zone.tag == 1 || zone.tag == 5 || zone.tag == 6 {
                zone.isHidden = false
            } else {
                zone.isHidden = true
            }
        }
        
        
        
        // NotificationCenter here observes SwipeLabel Behavior
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Here the orientation changes are
    
    @objc func rotated(){
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            swipeLabel.text = "Swipe Left to share"
        }
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            swipeLabel.text = "Swipe Up to share"
        }
    }
    
    // Behavior of tapped model buttons
    @IBAction func modelOneButtonAction(_ sender: UIButton) {
        setPushedModelOneButtonAftermaths()
    }
    
    @IBAction func modelTwoButtonAction(_ sender: UIButton) {
        setPushedModelTwoButtonAftermaths()
    }
    
    @IBAction func modelThreeButtonAction(_ sender: UIButton) {
        setPushedModelThreeButtonAftermaths()
    }
    
    // Plus Buttons//
    
    
    
    
    
    
    fileprivate func setPushedModelOneButtonAftermaths() {
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1Selected"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3"), for: UIControlState.normal)
        for zone in mainViewZones {
            if zone.tag == 1 || zone.tag == 5 || zone.tag == 6 {
                zone.isHidden = false
            } else {
                zone.isHidden = true
            }
        }
    }
    
    
    fileprivate func setPushedModelTwoButtonAftermaths(){
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2Selected"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3"), for: UIControlState.normal)
        for zone in mainViewZones {
            if zone.tag == 2 || zone.tag == 3 || zone.tag == 4 {
                zone.isHidden = false
            } else {
                zone.isHidden = true
            }
        }
    }
    
    fileprivate func setPushedModelThreeButtonAftermaths(){
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3Selected"), for: UIControlState.normal)
        for zone in mainViewZones {
            if zone.tag == 3 || zone.tag == 4 || zone.tag == 5 || zone.tag == 6 {
                zone.isHidden = false
            } else {
                zone.isHidden = true
            }
        }
    }
    
}


