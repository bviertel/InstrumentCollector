//
//  InstrumentViewController.swift
//  InstrumentCollector
//
//  Created by Ann Marie Seyerlein on 5/16/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var instrumentImageView: UIImageView!
    
    // Image Picker can be named whatever!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
