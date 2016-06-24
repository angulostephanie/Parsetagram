import UIKit
import Parse
import UIScrollView_InfiniteScroll

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [PFObject]?
    var initialLimit = 20
    //var isMoreDataLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkerrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tableView.dataSource = self
        tableView.delegate = self
        self.networkerrorLabel.hidden = true
        NSTimer.scheduledTimerWithTimeInterval(5, target:  self, selector: #selector(HomeViewController.onTimer), userInfo: nil, repeats: true)
        
        loadPosts()
        infiniteScroll()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        query.limit = initialLimit 
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:NSError?) in
            if error != nil {
                print(error)
            } else {
                print("Successfully retrieved \(objects!.count) posts. - Home View Controller")
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
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = self.posts![indexPath.row]
        let user = post["user"] as? PFUser
        let caption = post["caption"] as! String?
        
        if let photo = post["media"] {
            let imagePFFIle = photo as! PFFile
            imagePFFIle.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.photoView.image = image
                        cell.usernameLabel.text = user?.username
                        cell.usernameLabel2.text = user?.username
                        cell.captionLabel.text = caption
                    }
                }
            })
        }
        //print("Image exists - Home View Controller")
        //print("\(posts!.count)")
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func onTimer() {
       self.tableView.reloadData()
   }
    
    
//    //what is this controller lol
//    class ButtonViewController: UIViewController {
//        
//        @IBOutlet weak var closeButton: UIButton!
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view, typically from a nib.
//        }
//        
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//            
//        }
//        
//        //should close modal view
//        @IBAction func didTapCloseButton(sender: AnyObject) {
//            dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//    }
    

}

