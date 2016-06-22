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

        // Do any additional setup after loading the view.
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
                print("You are now logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            if success {
                print("Yayy user has been created")
                self.performSegueWithIdentifier("signUpSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == self.userNameTakenError {
                    print("Username has already been taken")
                    }
                }
            
            }
        }
    
}
