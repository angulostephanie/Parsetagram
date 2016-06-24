//
//  AppDelegate.swift
//  Parsetagram
//
//  Created by Stephanie Angulo on 6/20/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var navBarFont = UIFont(name: "Avenir", size: 20) ?? UIFont.systemFontOfSize(20)
    var navBarTextColor = UIColor.whiteColor()
    var navBarBackgroundColor: String! = "CC0033"
    var navBarAppearance = UINavigationBar.appearance()
    var window: UIWindow?
    var APP_ID: String! = "Parsetagram"
    var MASTER_KEY: String! = "jkdkjdfskksdka"
    var DOMAIN: String! = "frozen-atoll-64019.herokuapp.com"
    //var currentUser = PFUser.currentUser()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            navBarAppearance.titleTextAttributes = [NSFontAttributeName: navBarFont, NSForegroundColorAttributeName: navBarTextColor]
            navBarAppearance.tintColor = UIColor(red: 204.0/255.0, green :0.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = self.APP_ID
                configuration.clientKey = self.MASTER_KEY  // set to nil assuming you have not set clientKey
                configuration.server = ("https://\(self.DOMAIN)/parse")
            })
        )
       
        if PFUser.currentUser() != nil {
            let navBar = (self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("navigationBar"))! as UIViewController
            self.window?.rootViewController = navBar
            print("current user is still signed in")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //MARK: Facebook Integration
    
    //func applicationDidBecomeActive(application: UIApplication) {
      //  FBSDKAppEvents.activateApp()
   // }
    
    //func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
      //  return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
   // }
}

