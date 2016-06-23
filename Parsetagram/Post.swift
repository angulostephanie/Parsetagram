//
//  Post.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/21/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
   
    class func newPost(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        
        post["user"] = PFUser.currentUser()
        post["media"] = getPFFileFromImage(image) // a pffile
        post["caption"] = caption
        //post["likesCount"] = 0
        //post["commentsCount"] = 0
        post.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            if success {
                print("Success! - Post class")
                //performSegueWithIdentifier("uploadedSegue", sender: nil)
            }
            else {
                print(error)
                print("ERROR :( - Post class")
            }
        }

    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
