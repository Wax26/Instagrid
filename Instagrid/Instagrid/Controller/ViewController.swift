//
//  ViewController.swift
//  Instagrid
//
//  Created by Walim Aloui on 27/03/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // The three model buttons outlets
    @IBOutlet weak var modelOneButtonOutlet: UIButton!
    @IBOutlet weak var modelTwoButtonOutlet: UIButton!
    @IBOutlet weak var modelThreeButtonOutlet: UIButton!
    
    // The "Instagrid" Label
    @IBOutlet weak var swipeLabel: UILabel!
    
    @IBOutlet weak var upperRectangle: UIImageView!
    @IBOutlet weak var upperLeftSquare: UIImageView!
    @IBOutlet weak var upperRightSquare: UIImageView!
    @IBOutlet weak var downerRectangle: UIImageView!
    @IBOutlet weak var downerLeftSquare: UIImageView!
    @IBOutlet weak var downerRightSquare: UIImageView!
    @IBOutlet weak var mainSquare: UIImageView!
    
    // The Plus Outlets
    @IBOutlet weak var upperLeftPlusOutlet: UIButton!
    @IBOutlet weak var upperRightPlusOutlet: UIButton!
    
    @IBOutlet weak var downerCentralPlusOutlet: UIButton!
    @IBOutlet weak var upperCentralPlusOutlet: UIButton!
    @IBOutlet weak var downerLeftPlusOutlet: UIButton!
    @IBOutlet weak var downerRightPlusOutlet: UIButton!
    
    @IBAction func dragCentralView(_ sender: UIPanGestureRecognizer) {
        transormCentralView(gesture: sender)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    @objc func swipeCentralSquareView(swipe : UISwipeGestureRecognizer) {
        
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
    @IBAction func upperRectanglePlusButton(_ sender: UIButton) {
        
        pickAnImage()
        
    }
    
    @IBAction func upperLeftSquarePlusButton(_ sender: UIButton) {
      
        pickAnImage()
    }
    
    @IBAction func upperRightSquarePlusButton(_ sender: UIButton) {
        
        pickAnImage()
    }
    
    @IBAction func downerRectaglePlusButton(_ sender: UIButton) {
        
        pickAnImage()
        
    }
    @IBAction func downerRightSquarePlusButton(_ sender: UIButton) {
        
        pickAnImage()
    }
   
    
    @IBAction func downerLeftSquarePlusButton(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
    fileprivate func setPushedModelOneButtonAftermaths() {
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1Selected"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3"), for: UIControlState.normal)
        upperLeftSquare.isHidden = true
        upperRightSquare.isHidden = true
        upperRectangle.isHidden = false
        downerRectangle.isHidden = true
        downerLeftSquare.isHidden = false
        downerRightSquare.isHidden = false
    }
    
    
    fileprivate func setPushedModelTwoButtonAftermaths(){
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2Selected"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3"), for: UIControlState.normal)
        upperLeftSquare.isHidden = false
        upperRightSquare.isHidden = false
        upperRectangle.isHidden = true
        downerRectangle.isHidden = false
        downerLeftSquare.isHidden = true
        downerRightSquare.isHidden = true
    }
    
    fileprivate func setPushedModelThreeButtonAftermaths(){
        modelOneButtonOutlet.setImage(#imageLiteral(resourceName: "model1"), for: UIControlState.normal)
        modelTwoButtonOutlet.setImage(#imageLiteral(resourceName: "model2"), for: UIControlState.normal)
        modelThreeButtonOutlet.setImage(#imageLiteral(resourceName: "model3Selected"), for: UIControlState.normal)
        upperLeftSquare.isHidden = false
        upperRightSquare.isHidden = false
        upperRectangle.isHidden = true
        downerRectangle.isHidden = true
        downerLeftSquare.isHidden = false
        downerRightSquare.isHidden = false
    }
    
    fileprivate func pickAnImage(){
      
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Source d'Image", message: "Veuillez choisir entre la Photothèque et la Camera", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photothèque", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        /* CEMERA
         actionSheet.addAction(UIAlertAction(title: "Caméra", style: .default, handler: { (action : UIAlertAction) in
         imagePickerController.sourceType = .camera
         self.present(imagePickerController, animated: true, completion: nil)
         }))
         */
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        upperLeftSquare.image = image
    
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   

    func getTheImageView(pushedPlus : UIButton) -> UIImageView {
        var imageView = UIImageView()
        if pushedPlus == upperLeftPlusOutlet {
        imageView =  upperLeftSquare
    } else if pushedPlus == upperRightPlusOutlet {
        imageView =  upperRightSquare
        } else if pushedPlus == upperCentralPlusOutlet {
                imageView =  upperRectangle
        } else if pushedPlus == downerLeftPlusOutlet {
            imageView = downerLeftSquare
        } else if pushedPlus == downerRightPlusOutlet {
            imageView = downerRightSquare
        } else {
            imageView = downerRectangle
        }
        return imageView
    }
    
    // The Traslation Part
    private func transormCentralView(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: mainSquare)
        let translationTransform = CGAffineTransform(translationX: translation.x , y: translation.y)
        let screenWidth = UIScreen.main.bounds.width
        let translationPercent = translation.x / (screenWidth/2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let transform = translationTransform.concatenating(rotationTransform)
        mainSquare.transform = transform
        
       
    }
}

