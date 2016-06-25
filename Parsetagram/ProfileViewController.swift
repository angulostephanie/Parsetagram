//
//  ProfileViewController.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/20/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse
import UIScrollView_InfiniteScroll

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var initialLimit = 20
    var posts: [PFObject]?
    //var homeView = HomeViewController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tableView.dataSource = self
        tableView.delegate = self
        //self.networkerrorLabel.hidden = true
        NSTimer.scheduledTimerWithTimeInterval(5, target:  self, selector: #selector(HomeViewController.onTimer), userInfo: nil, repeats: true)
        profileUsernameLabel.text = PFUser.currentUser()!.username
        loadPosts()
        infiniteScroll()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func infiniteScroll() {
        tableView.addInfiniteScrollWithHandler { (scrollView) -> Void in
            let tableView = scrollView as! UITableView
            self.initialLimit += 20
            self.loadPosts()
            if self.initialLimit > self.posts?.count {
                self.initialLimit = (self.posts?.count)!
            }
            tableView.reloadData()
            print("\(self.initialLimit) is now the limit")
            tableView.finishInfiniteScroll()
        }
    }
    
    func loadPosts() {
        let query = PFQuery(className:"Post")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.limit = initialLimit
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:NSError?) in
            if error != nil {
                print(error)
            } else {
                print("Successfully retrieved \(objects!.count) posts. - Profile View Controller")
                self.posts = objects
                //print("\(self.initialLimit) is now the limit")
                self.tableView.reloadData()
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        loadPosts()
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileTableViewCell
        
        let post = self.posts![indexPath.row]
        let user = post["user"] as? PFUser
        let caption = post["caption"] as! String?
        cell.usernameLabel.text = user?.username
        print("hello")
        cell.usernameLabel2.text = user?.username
        cell.captionLabel.text = caption
        
        if let photo = post["media"] {
           let imagePFFIle = photo as! PFFile
           imagePFFIle.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        
                        let image = UIImage(data:imageData)
                        cell.photoView.image = image
                        
                        
                        
                        print("\(caption)")
                    }
                }
            })
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func onTimer() {
        self.tableView.reloadData()
    }
    
    
    @IBAction func onLogOut(sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to log out?", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        
        }
        let logoutAction = UIAlertAction(title: "Log Out", style: .Destructive) { (action) in
            PFUser.logOutInBackgroundWithBlock { (error: NSError?) in }
            self.performSegueWithIdentifier("logOutSegue", sender: nil)
        }
        // add the logout action to the alert controller
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true) {}
    }
   
}
