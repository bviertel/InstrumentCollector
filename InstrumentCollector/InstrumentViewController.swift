//
//  InstrumentViewController.swift
//  InstrumentCollector
//
//  Created by Brandon Viertel on 5/16/17.
//  Copyright © 2017 Brandon. All rights reserved.
//
//  OTHER NOTES:
//  Delegate: Where does it get it's control from; what it controls; etc.
//  Note how 'context' is implemented and utilized

import UIKit

// Don't forget to add UIImagePickerControllerDelegate and UINavigationControllerDelegate!

class InstrumentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // OUTLET VARIABLES
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var instrumentImageView: UIImageView!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
// OTHER VARIABLES
    
    // Image Picker can be named whatever
    
    var imagePicker = UIImagePickerController()
    
    // For checking if adding new or editing preexisting
    
    var instrument : Instrument? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        // Buttons, Labels, and Actions change based on 'Adding' or 'Updating'
        
        if instrument != nil {
            
            // Gets Image, Name (title), from Core Data and changes 'Add' to 'Update'
            
            instrumentImageView.image = UIImage(data: instrument!.image as! Data)
            
            titleTextField.text = instrument!.name
            
            // Changes label item
            
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
            
            // Hides 'Delete' if adding new item
            
            deleteButton.isHidden = true
            
        }
   
    }
    
// ACTIONS
    
    @IBAction func photosTapped(_ sender: Any) {
        
        // Where the Image Picker gets to select from
        
        imagePicker.sourceType = .photoLibrary
        
        // Displays the Photo Library to the user
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // Gets data about selected image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        // UIImage: data around an image file
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Changes the image on the storyboard to the selected image
        
        instrumentImageView.image = image
        
        // Dismisses the image picker, otherwise will not disappear on own
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        // Where the Image Picker gets to select from
        
        imagePicker.sourceType = .camera
        
        // Displays the Photo Library to the user
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if instrument != nil {
            
            instrument!.name = titleTextField.text
            
            // Gets image from the image view. However, instrument.image is an NSData object, and instrumentImageView is a UIImage, so we need to convert the UIImage to the NSData object by converting it to a PNG
            
            // Something fishy with NSData
            
            instrument!.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let instrument = Instrument(context: context)
            
            instrument.name = titleTextField.text
            
            // Gets image from the image view. However, instrument.image is an NSData object, and instrumentImageView is a UIImage, so we need to convert the UIImage to the NSData object by converting it to a PNG
            
            // Something fishy with NSData
            
            instrument.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
            
        }
        
        // Saves the context of data from the 'instrumentViewController'
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Pops back to Table View
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Deletes the item
        
        context.delete(instrument!)
        
        // Saves the context of data from the 'instrumentViewController'
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Pops back to Table View
        
        navigationController!.popViewController(animated: true)

        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    
    }
    
}
