//
//  ViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/20/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [PFObject]? {
        didSet {
            print("SEt messages")
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSTimer.scheduledTimerWithTimeInterval(5, target:  self, selector: #selector(HomeViewController.onTimer), userInfo: nil, repeats: true)

        let query = PFQuery(className:"Post")
        query.orderByDescending("createdAt")
        query.includeKey("user")

        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:NSError?) in
            if error != nil {
                print(error)
            } else {
                print("Successfully retrieved \(objects!.count) posts.")
                self.posts = objects
                self.tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = posts![indexPath.row]
        let user = post["user"] as? PFUser
        let image = post["media"] as?
        cell.usernameLabel.text = user?.username
        cell.photoView.image  = image
        //cell.usernameLabel2.text = user.username
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50 //posts?.count ?? 0
    }
    
    func onTimer() {
        self.tableView.reloadData()
    }
    
    
    //what is this controller lol
    class ButtonViewController: UIViewController {
        
        @IBOutlet weak var closeButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            
        }
        
        //should close modal view
        @IBAction func didTapCloseButton(sender: AnyObject) {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    

}

