//
//  ViewController.swift
//  ImagePicker
//
//  Created by Hossameldien Hamada on 7/7/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import UIKit

class MemeMeController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    // MARK:- Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var lowerTextField: UITextField!
    @IBOutlet weak var upperTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //MARK:- Constants
    let textFieldsDelegate = TextFieldsDelegate()
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 40)!,
        .strokeWidth:  NSNumber(-3.0)]
    
    //MARK:- Variables
    var memedImage: UIImage!
    var upperText = "TOP"
    var lowerText = "BOTTOM"
    var originalImage: UIImage!
    var calledToEdit = false
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetText()
        setupTextFields(upperTextField)
        setupTextFields(lowerTextField)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        enableButtons(false)
        subscribeToKeyboardNotifications()
        
        if(originalImage != nil){
            imagePickerView.image = originalImage
        }
        if(calledToEdit){
            bottomToolbar.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK:- Actions
    @IBAction func imagePickerAlbum(_ sender: Any) {
        setImagePickerController(true)
    }
    
    
    @IBAction func imagePickerCamera(_ sender: Any) {
        setImagePickerController(false)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            if(success){
                self.save()
            }
            self.performCancel()
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        performCancel()
    }
    
    //MARK:- Functions
    func hideToolbars(_ isHidden: Bool){
        
        topToolbar.isHidden = isHidden
        bottomToolbar.isHidden = isHidden
    }
    
    func enableButtons(_ isEnabled: Bool){
        if(!calledToEdit){
            cancelButton.isEnabled = isEnabled
            shareButton.isEnabled = isEnabled
        }
    }
    
    func resetText(){
        upperTextField.text = upperText
        lowerTextField.text = lowerText
    }
    
    func performCancel(){
        imagePickerView.image = nil
        resetText()
        enableButtons(false)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupTextFields(_ textField: UITextField){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = textFieldsDelegate
        textField.adjustsFontSizeToFitWidth = true
    }
}

