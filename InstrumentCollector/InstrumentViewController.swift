//
//  InstrumentViewController.swift
//  InstrumentCollector
//
//  Created by Ann Marie Seyerlein on 5/16/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var instrumentImageView: UIImageView!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    // Image Picker can be named whatever!
    
    var imagePicker = UIImagePickerController()
    
    // For new /preexisting
    
    var instrument : Instrument? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if instrument != nil {
            
            instrumentImageView.image = UIImage(data: instrument!.image as! Data)
            
            titleTextField.text = instrument!.name
            
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
            
            deleteButton.isHidden = true
            
        }
   
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // Gets info about selected image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        // UIImage: data around an image file
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Changes the image on the storyboard to the selected image
        
        instrumentImageView.image = image
        
        // Dismisses the image picker, otherwise will not disappear on own
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }

    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let instrument = Instrument(context: context)
        
        instrument.name = titleTextField.text
        
        // Gets image from the image view. However, instrument.image is an NSData object, and instrumentImageView is a UIImage, so we need to convert the UIImage to the NSData object by converting it to a PNG
        
        // Something fishy with NSData
        
        instrument.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
