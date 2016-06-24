//
//  SignUpViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/22/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var userNameTakenError: Int! = 202    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        // set user properties
        newUser.email = emailField.text
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            if success {
                print("User has been created - Sign Up View Controller")
                self.performSegueWithIdentifier("userCreatedSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == self.userNameTakenError {
                    print("Username has already been taken - Sign Up View Controller")
                }
            }
            
        }
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
