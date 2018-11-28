//
//  ViewController.swift
//  Instagrid
//  Created by Walim Aloui on 27/03/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    // MARK: GLOBAL DECLARATIONS
    
    // The Location Manager Declaration
    var locationManager = CLLocationManager()
    
    // The Swipe Gesture Declaration
    var swipeGesture = UISwipeGestureRecognizer()
    
    // The Picker Controller Declaration
    let imagePickerController = UIImagePickerController()
    
    
    
    // MARK : GLOBAL VARIABLES
    
    // The Pressed "Plus Button" tag
    var pressedPlusButtonTag : Int?
    
    
    
    // MARK: STORYBOARD OUTLETS
    
    // Outlet managing the central grid
    @IBOutlet var mainSquareView : MainSquareView!
    
    // Outlet managing the three white buttons
    @IBOutlet var patternButtonArray : [UIButton]!
    
    // The "Instagrid" Label
    @IBOutlet weak fileprivate var swipeLabel: UILabel!
    
    // The label under the Blue Square
    @IBOutlet weak  var locationTextField: UITextField!
    
    // The Location Icon Outlet
    @IBOutlet weak fileprivate var locationIcon: UIButton!
    
    
    
    // MARK : VIEWCONTROLLER'S OVERRRIDDEN FUNCTIONS
    
    // Sets top bar to white color
    override  var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // Called when screen detects a touch. This function, makes the keyboard disappear in a smart way in case of a touch onto the screen !
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    //MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setAllDelegates()
        setAllNotificationCenters()
        setDefaultSelectedPatternArray()
        setDefaultGraphicSettings()
        setTheSwipeMoves()
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name : UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    fileprivate func setDefaultSelectedPatternArray() {
        // Selecting default pattern at launch (by default, second pattern)
        patternButtonArray[1].isSelected = true
        patternButtonArray[0].isSelected = false
        patternButtonArray[2].isSelected = false
    }
    
    fileprivate func setDefaultGraphicSettings() {
        locationIcon.isHidden = false
        
        // Applying the default pattern to the 'Grid', here the mainSquareView
        mainSquareView.setSecondPattern()
        mainSquareView.selectedPattern = .patternTwo
    }
    
    fileprivate func setAllDelegates() {
        locationTextField.delegate = self
        imagePickerController.delegate = self
    }
    
    fileprivate func setAllNotificationCenters() {
        // NotificationCenter here observes SwipeLabel Behavior and changes its text
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelDueToOrientation), name:
            
            UIDevice.orientationDidChangeNotification, object: nil)
        // Keyboard Notification Center, listening to keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    fileprivate func setTheSwipeMoves() {
        // Sets the Swipe Moves
        
        let directionArray: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        
        for direction in directionArray{
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeView(_:)))
            mainSquareView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            mainSquareView.isUserInteractionEnabled = true
            mainSquareView.isMultipleTouchEnabled = true
        }
    }
    
    
    // MARK: - IBACTIONS
    
    // Touch The location Button to find yours
    @IBAction  func locationButtonTapped(_ sender: UIButton) {
        locationManager.delegate = (self as CLLocationManagerDelegate)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Add a picture with these buttons
    @IBAction  func plusButtonTapped(_ sender: UIButton) {
        pressedPlusButtonTag = sender.tag
        manageImagePicking(sender)
    }
    
    fileprivate func manageImagePicking(_ sender: UIButton) {
        // ImagePickerController Declaration
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.sourceType = .photoLibrary;
            imagePickerController.allowsEditing = true
            present(imagePickerController, animated: true, completion: nil)
            print(sender.tag)
        }
    }
    
    // Deletes all images and sets initial background color
    @IBAction  func trashButtonPushed(_ sender: UIButton) {
        deleteAllImages()
    }
    
    fileprivate func deleteAllImages() {
        let refreshAlert = UIAlertController(title: "Delete all images", message: "All pictures will be removed. Are you sure ?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.mainSquareView.deleteImages()
            self.view.backgroundColor = #colorLiteral(red: 0.6857407689, green: 0.847186029, blue: 0.9051745534, alpha: 1)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    // Select the wanted pattern with theses buttons
    @IBAction  func patternButtonTapped(_ sender: UIButton) {
        unselectPatternButtons()
        patternButtonArray[sender.tag].isSelected = true
        
        switch sender.tag {
        case 0:
            mainSquareView.setFirstPattern()
            mainSquareView.selectedPattern = .patternOne
            
        case 1:
            mainSquareView.setSecondPattern()
            mainSquareView.selectedPattern = .patternTwo
        case 2 :
            mainSquareView.setThirdPattern()
            mainSquareView.selectedPattern = .patternThree
        default:
            break
        }
        manageBackGroundColor()
    }
    
    // Unselect all patterns before enabling the one the user has chosen
    fileprivate func unselectPatternButtons() {
        patternButtonArray.forEach { (button) in
            button.isSelected = false
        }
    }
    
    // MARK: OBC FUNCTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
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
            print(info)
        }
    }
    
    @objc fileprivate func swipeView(_ sender:UISwipeGestureRecognizer){
        if mainSquareView.checkIfZoneIsFullWithImage(){
            guard UIDevice.current.orientation.isPortrait else {
                if sender.direction == .left {
                    self.mainSquareView.squareViewGoesLeft()
                    self.presentActivityController()
                }
                return
            }
            guard sender.direction == .right else {
                if sender.direction == .left {
                    
                } else if sender.direction == .up {
                    self.mainSquareView.squareViewGoesUp()
                    self.presentActivityController()
                } else if sender.direction == .down {
                    
                }
                return
            }
        }
    }
    
    
    @objc fileprivate func changeLabelDueToOrientation(){
        if(UIDevice.current.orientation.isLandscape) {
            swipeLabel.text = "Swipe Left to share"
        } else {
            swipeLabel.text = "Swipe Up to share"
        }
    }
}















