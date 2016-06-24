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
        post["media"] = getPFFileFromImage(image)
        post["caption"] = caption
//        post["data"] = getDate(date)
        post["likesCount"] = 0
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
//    func getDate(date: NSDate?) -> String? {
//        let currentDate = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
//        let date = NSLog("%@", dateFormatter.stringFromDate(currentDate))
//        return date
//    }
    
    
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
