//
//  DetailViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/22/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    var post: PFObject!
    
   
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    //@IBOutlet weak var photoView: UIImageView!
    //@IBOutlet weak var usernameLabel2: UILabel!
    //@IBOutlet weak var captionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
        importData()
        // Do any additional setup after loading the view.
    }
    func importData() {
        //let post = self.posts![indexPath.row]
        let user = post["user"] as? PFUser
        let caption = post["caption"] as! String?
        
        if let photo = post["media"] {
            let imagePFFIle = photo as! PFFile
            imagePFFIle.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.photoView.image = image
                        self.usernameLabel.text = user?.username
                        self.usernameLabel2.text = user?.username
                        self.captionLabel.text = caption
                    }
                }
            })
        }    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
