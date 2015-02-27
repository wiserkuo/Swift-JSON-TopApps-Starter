//
//  ViewController.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/1/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
        // Get the number 1 app using optional binding and NSJSONSerialization
        //1
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        //2
        if let topApps = parsedObject as? NSDictionary {
            if let feed = topApps["feed"] as? NSDictionary {
                if let apps = feed["entry"] as? NSArray {
                    if let firstApp = apps[0] as? NSDictionary {
                        if let imname = firstApp["im:name"] as? NSDictionary {
                            if let appName = imname["label"] as? NSString {
                                //3
                                println("Optional Binding: \(appName)")
                            }
                        }
                    }
                }
            }
        }
    }*/
    DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
        // Get #1 app name using SwiftyJSON
        let json = JSON(data: data)
        if let appName = json["feed"]["entry"][0]["im:name"]["label"].string {
            println("SwiftyJSON: \(appName)")
        }
    }
    DataManager.getTopAppsDataFromGMSWithSuccess { (GMSData) -> Void in
        
        let json = JSON(data: GMSData)
        if let lat = json["results"][0]["geometry"]["location"]["lat"].double {
            print("lat: \(lat),")
        }
        if let lng = json["results"][0]["geometry"]["location"]["lng"].double {
            println("lng: \(lng)")
        }
    }
    // Get the #1 app name from iTunes and SwiftyJSON
    DataManager.getTopAppsDataFromItunesWithSuccess { (iTunesData) -> Void in
        
        let json = JSON(data: iTunesData)
        if let appName = json["feed"]["entry"][0]["im:name"]["label"].string{
            println("NSURLSession: \(appName)")
        }
        // More soon...
        //1
        if let appArray = json["feed"]["entry"].array {
            //2
            var apps = [AppModel]()
            
            //3
            for appDict in appArray {
                var appName: String? = appDict["im:name"]["label"].stringValue
                var appURL: String? = appDict["im:image"][0]["label"].stringValue
                
                var app = AppModel(name: appName, appStoreURL: appURL)
                apps.append(app)
            }
            
            //4
            println(apps)
        }
    }
  }
}

