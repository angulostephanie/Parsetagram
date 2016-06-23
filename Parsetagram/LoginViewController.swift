//
//  LoginViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/20/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    var userNameTakenError: Int! = 202
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //usernameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                print("You are now logged in - Log View Controller")
            self.performSegueWithIdentifier("loggingInSegue", sender: nil)
            }
            
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("newUserSegue", sender: nil)    }
    
}
