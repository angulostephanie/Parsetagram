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
    
    var posts: [PFObject]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkerrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.networkerrorLabel.hidden = true
        onQuery()
        NSTimer.scheduledTimerWithTimeInterval(5, target:  self, selector: #selector(HomeViewController.onTimer), userInfo: nil, repeats: true)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPathForCell(cell)
//        let post = posts![indexPath!.row]
//        let detailViewController = segue.destinationViewController as! DetailViewController
//        //detailViewController.movie = movie
//        print("prepare for segue has been called")
//    }
    
    func onQuery() {
        let query = PFQuery(className:"Post")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:NSError?) in
            if error != nil {
                print(error)
            } else {
                print("Successfully retrieved \(objects!.count) posts. - Home View Controller")
                self.posts = objects
                print("\(self.posts)")
                self.tableView.reloadData()
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        onQuery()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        //print("\(posts)")
        
        let post = self.posts![indexPath.row]
        let user = post["user"] as? PFUser
        let caption = post["caption"] as! String?
        
        if let photo = post["media"] {
            let imagePFFIle = photo as! PFFile
            imagePFFIle.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        print("Image exists - Home View Controller")
                        cell.photoView.image = image
                        cell.usernameLabel.text = user?.username
                        cell.usernameLabel2.text = user?.username
                        cell.captionLabel.text = caption
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

