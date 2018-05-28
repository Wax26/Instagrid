//
//  ViewController.swift
//  Instagrid
//
//  Created by Walim Aloui on 27/03/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet var mainSquareView : MainSquareView!
    
    // The three model buttons outlets@IBOutlet weak var modelOneButtonOutlet: UIButton!@IBOutlet weak var modelTwoButtonOutlet: UIButton!    @IBOutlet weak var modelThreeButtonOutlet: UIButton!
    @IBOutlet var patternButtonArray : [UIButton]!
    
    // The "Instagrid" Label
    @IBOutlet weak var swipeLabel: UILabel!
    
    // Swipe Gesture Declaration
    var swipeGesture = UISwipeGestureRecognizer()
    
    // Tag of the pressed plus button
    var pressedPlusButtonTag : Int?
    
    // ImagePickerController Declaration
    let imagePickerController = UIImagePickerController()
    
    
    @IBAction func patternButtonTapped(_ sender: UIButton) {
        unselectPatternButtons()
        patternButtonArray[sender.tag].isSelected = true
        
        switch sender.tag {
        case 0:
            print("case 0")
            mainSquareView.setFirstPattern()
            mainSquareView.selectedPattern = .patternOne
            let zone = mainSquareView.center
            print(zone)
        case 1:
            print("case 1")
            mainSquareView.setSecondPattern()
            mainSquareView.selectedPattern = .patternTwo
        case 2 :
            print("case 2")
            mainSquareView.setThirdPattern()
            mainSquareView.selectedPattern = .patternThree
        default:
            break
        }
    }
    
    
    func unselectPatternButtons() {
        patternButtonArray.forEach { (button) in
            button.isSelected = false
        }
    }
    
    
    @IBAction func trashButtonPushed(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Deletion", message: "All pictures will be removed.", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.mainSquareView.deleteImages()
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @objc func swipeView(_ sender:UISwipeGestureRecognizer){
        
        if mainSquareView.checkIfZoneIsFullWithImage() == true {
            print(mainSquareView.checkIfZoneIsFullWithImage())
            if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
                UIView.animate(withDuration: 0.5) {
                    if sender.direction == .right {
                        print("right")
                    }else if sender.direction == .left {
                        print("left")
                    }else if sender.direction == .up {
                        print("up")
                        self.mainSquareView.goUp()
                        self.presentSharePopUp()
                    }else if sender.direction == .down {
                        print("down")
                    }
                }
            } else   {
                UIView.animate(withDuration: 0.5) {
                    if sender.direction == .left {
                        
                        self.mainSquareView.frame = CGRect(x: -self.view.frame.size.width, y: self.mainSquareView.frame.origin.y, width: self.mainSquareView.frame.size.width, height: self.mainSquareView.frame.size.height)
                        self.presentSharePopUp()
                    }
                    
                }
            }
        }
        
    }
    // Here has to be added the image file to provide
    func presentSharePopUp() {
        
        
        
        
        let image = UIImage(view : mainSquareView)
        let imageArray = [image]
        let activityViewController = UIActivityViewController( activityItems: imageArray,applicationActivities: nil)
        
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)){
                UIView.animate(withDuration: 0.3 ) {
                    self.mainSquareView.getBackDown()
                    
                    
                }
                
                
            } else {
                self.mainSquareView.getBackRight()
                
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // Testing the alert popover
    
    
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        pressedPlusButtonTag = sender.tag
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        for imageView in mainSquareView.imageViewsArray {
            if imageView.tag == pressedPlusButtonTag {
                imageView.image = image
                for button in mainSquareView.plusButtonsArray {
                    if button.tag == pressedPlusButtonTag{
                        button.isHidden = true
                    }
                }
            }
            
            dismiss(animated:true, completion: nil)
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternButtonArray[1].isSelected = true
        imagePickerController.delegate = self
        
        mainSquareView.setSecondPattern()
        mainSquareView.selectedPattern = .patternTwo
        
        // NotificationCenter here observes SwipeLabel Behavior
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelDueToOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        // Sets the Swipe Moves

        let direction: [UISwipeGestureRecognizerDirection] = [.up, .down, .left, .right]
        for dir in direction{
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeView(_:)))
            mainSquareView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = dir
            mainSquareView.isUserInteractionEnabled = true
            mainSquareView.isMultipleTouchEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeLabelDueToOrientation(){
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
            swipeLabel.text = "Swipe Left to share"
        }
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)){
            swipeLabel.text = "Swipe Up to share"
        }
    }
    
    // Screen has rotated
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Rotate")
    }
    
    
}



