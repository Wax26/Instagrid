//
//  ViewController.swift
//  Instagrid
//  Created by Walim Aloui on 27/03/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit
import CoreLocation

// TODO: Document better the ViewCtrller

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    // MARK: - PROPERTIES

    // Outlet managing the central grid
    @IBOutlet var mainSquareView : MainSquareView!
    
    // Outlet managing the three white buttons
    @IBOutlet var patternButtonArray : [UIButton]!
    
    // The "Instagrid" Label
    @IBOutlet weak fileprivate var swipeLabel: UILabel!
    
    // The label which includes location text
    @IBOutlet weak internal var locationTextField: UITextField!
    
    @IBOutlet weak fileprivate var locationIcon: UIButton!
   
    // The location manager variable
     var locationManager : CLLocationManager!
    
    // Sets top bar to white color
    override internal var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
  
    // Tag of the pressed plus button
  fileprivate var pressedPlusButtonTag : Int?

    // Swipe Gesture Declaration
  fileprivate  var swipeGesture = UISwipeGestureRecognizer()
    
    // ImagePickerController Declaration
fileprivate    let imagePickerController = UIImagePickerController()
  
    
    var frameView : UIView!
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.locationTextField.delegate = self
        imagePickerController.delegate = self
        
        locationIcon.isHidden = false
        
        // Selecting default pattern at launch (by default, second pattern)
        patternButtonArray[1].isSelected = true
        patternButtonArray[0].isSelected = false
        patternButtonArray[2].isSelected = false
      
        // Applying the pattern to the 'Grid', here the mainSquareView
        mainSquareView.setSecondPattern()
        mainSquareView.selectedPattern = .patternTwo
        
        // NotificationCenter here observes SwipeLabel Behavior and changes its text
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelDueToOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // Sets the Swipe Moves
        
        let directionArray: [UISwipeGestureRecognizerDirection] = [.up, .down, .left, .right]
        for direction in directionArray{
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeView(_:)))
            mainSquareView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            mainSquareView.isUserInteractionEnabled = true
            mainSquareView.isMultipleTouchEnabled = true
        }
        
        // Keyboard Notification Center, listening to keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
 
    deinit{
        NotificationCenter.default.removeObserver(self, name : NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    
    
    
    
    
    // MARK: - ACTIONS

    // Touch The location Button to find yours
    @IBAction fileprivate func locationButtonTapped(_ sender: UIButton) {
        locationManager = CLLocationManager()
        locationManager.delegate = (self as CLLocationManagerDelegate)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Called when screen detects a touch
    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction fileprivate func patternButtonTapped(_ sender: UIButton) {
        unselectPatternButtons()
        patternButtonArray[sender.tag].isSelected = true
        
        switch sender.tag {
        case 0:
            mainSquareView.setFirstPattern()
            mainSquareView.selectedPattern = .patternOne
            manageBackGroundColor()
        case 1:
            mainSquareView.setSecondPattern()
            mainSquareView.selectedPattern = .patternTwo
            manageBackGroundColor()
        case 2 :
            mainSquareView.setThirdPattern()
            mainSquareView.selectedPattern = .patternThree
            manageBackGroundColor()
        default:
            break
        }
    }
    
    // Unselect patterns before enabling the one the user has chosen
   fileprivate func unselectPatternButtons() {
        patternButtonArray.forEach { (button) in
            button.isSelected = false
        }
    }
    
    @IBAction fileprivate func trashButtonPushed(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Deletion", message: "All pictures will be removed. Are you sure ?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.mainSquareView.deleteImages()
               self.view.backgroundColor = #colorLiteral(red: 0.6857407689, green: 0.847186029, blue: 0.9051745534, alpha: 1)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
     
    }
    
    @objc fileprivate func swipeView(_ sender:UISwipeGestureRecognizer){
        guard mainSquareView.checkIfZoneIsFullWithImage() else {
            return
        }
        guard UIDevice.current.orientation.isPortrait else {
            if sender.direction == .left {
                self.mainSquareView.squareViewGoesLeft()
                self.presentSharePopUp()
            }
            return
        }
        guard sender.direction == .right else {
             if sender.direction == .left {
              
            } else if sender.direction == .up {
                self.mainSquareView.squareViewGoesUp()
                self.presentSharePopUp()
             } else if sender.direction == .down {

            }
            return
        }
    }
    
    // Here has to be added the image file to provide
   fileprivate func presentSharePopUp() {
       
        guard let image = mainSquareView.convertToUIImage() else {
            return}
        let imageArray = [image]
        let activityViewController = UIActivityViewController( activityItems: imageArray,applicationActivities: nil)
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

    @IBAction fileprivate func plusButtonTapped(_ sender: UIButton) {
        pressedPlusButtonTag = sender.tag
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc  internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("No image found")
            return
        }
        for imageView in mainSquareView.imageViewsArray {
            if imageView.tag == pressedPlusButtonTag {
                imageView.image = image
                for button in mainSquareView.plusButtonsArray {
                    if button.tag == pressedPlusButtonTag{
                        button.isHidden = true
                    }
                }
                manageBackGroundColor()
            }
            dismiss(animated:true, completion: nil)
        }
    }
    
    override internal func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc fileprivate func changeLabelDueToOrientation(){
        if(UIDevice.current.orientation.isLandscape) {
            swipeLabel.text = "Swipe Left to share"
        }
        if(UIDevice.current.orientation.isPortrait){
            swipeLabel.text = "Swipe Up to share"
        }
    }

    // Happens when pattern is complete
   fileprivate func manageBackGroundColor() {

        if mainSquareView.checkIfZoneIsFullWithImage() {
              self.view.backgroundColor = #colorLiteral(red: 0.6017822224, green: 0.6626180173, blue: 0.8655655832, alpha: 1)
        } else {
            self.view.backgroundColor = #colorLiteral(red: 0.6857407689, green: 0.847186029, blue: 0.9051745534, alpha: 1)
        }
    }
 
  fileprivate  func hideKeyboard() {
        locationTextField.resignFirstResponder()
        
    }
    
    @objc fileprivate func keyboardWillChange(notification : Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
            
        }
        
    }
    
    
    // Hides the keyboard when "return"
    internal func textFieldShouldReturn(_ textField : UITextField) -> Bool {
       
        hideKeyboard()
        return true
    }
    
    
}


