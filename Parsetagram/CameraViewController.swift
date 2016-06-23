//
//  CameraViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/20/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onLibrary(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func onCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoView.contentMode = .ScaleAspectFit
            photoView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func onUpload(sender: AnyObject) {
        let photo = photoView.image
        Post.newPost(photo, withCaption: captionField.text) { (success: Bool, error: NSError?) in
            if success {
                print("Success - Camera View Controller")
                //self.performSegueWithIdentifier("uploadedSegue", sender: nil)
            }
            else {
                print(error)
                print("Did not upload - Camera View Controller")
                //INSERT ALERT (CANNOT UPLOAD)
            }
        }
    }
    
    
    

}
