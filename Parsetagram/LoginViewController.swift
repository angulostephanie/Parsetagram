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
    var usernameRequired: Int! = 200
    var passwordRequired: Int! = 201
    var invalidUsernamePassword: Int! = 101
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
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
            if error?.code == self.invalidUsernamePassword {
                print("alert controller displayed - login view controller")
                let alertController = UIAlertController(title: "Invalid Username/Password", message: "", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true) { }
            }
            if error?.code == self.usernameRequired {
                print("alert controller displayed - login view controller")
                let alertController = UIAlertController(title: "Username required", message: "", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true) { }
            }
            if error?.code == self.passwordRequired {
                print("alert controller displayed - login view controller")
                let alertController = UIAlertController(title: "Password required", message: "", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true) { }
            }

        }
        
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("newUserSegue", sender: nil)
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}