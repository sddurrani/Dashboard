//
//  DetailViewController.swift
//  Dashboard
//
//  Created by Saad Durrani on 5/9/18.
//  Copyright © 2018 Khan and Mike Org. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var lightImage: UIImageView!

    @IBOutlet weak var lightDescription: UITextView!
    
    var destValue:Lights?
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        detailDescriptionLabel.text = destValue?.lightname
        
        lightDescription.text = destValue?.lightdesc
        
        /*let imgURL = URL(string: "https://api.myjson.com/bins/1dxtga" + (destValue?.lightname)!)
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        lightImage?.image = img
        lightImage?.contentMode = .scaleAspectFill
        lightImage!.layer.cornerRadius = 0
        lightImage!.clipsToBounds = true*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubView" {
            let destController = segue.destination as! SubViewController
            destController.lightOpen = destValue!
        }
    }


}


//
//  MasterViewController.swift
//  Dashboard
//
//  Created by Saad Durrani on 5/9/18.
//  Copyright © 2018 Khan and Mike Org. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var LightsArray = [Lights]()
    
    func initializeArray() {
        
        //Rest API end point for recieve Exercises for JSON
        let jsonURLString = "https://api.myjson.com/bins/1dxtga"
        var jsonURL:URL = URL(string: jsonURLString)!
        
        let jsonUrlData = try? Data (contentsOf: jsonURL)
        
        print(jsonUrlData ?? "Error. No Data found at end point. Exiting.")
        
        if (jsonUrlData != nil) {
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: jsonUrlData!, options:
                JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            
            let YellowLights = dictionary["Yellowlights"]! as! [[String:AnyObject]]
            
            for index in 0...YellowLights.count - 1 {
                
                var light:Lights = Lights()
                
                var selectedLight = YellowLights[index]
                
                light.lightname = selectedLight["lightname"] as! String
                light.lightcat = selectedLight["lightcat"] as! String
                light.lightdesc = selectedLight["lightdesc"] as! String
                light.lightid = selectedLight["lightid"] as! Int32
                light.lightimagename = selectedLight["lightimagename"] as! String
                light.lighturl = selectedLight["lighturl"] as! String
                
                LightsArray.append(light)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeArray()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = LightsArray[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.destValue = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LightsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = LightsArray[indexPath.row]
        cell.textLabel!.text = object.lightname
        cell.detailTextLabel!.text = object.lightcat
        
        //Add the images
        /*let imgURL = URL(string: "http://www.protogic.com/images/" + (object.lightname))
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        cell.imageView?.image = img
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView!.layer.cornerRadius = 0
        cell.imageView!.clipsToBounds = true*/
        
        tableView.separatorColor = UIColor.brown
        tableView.tableFooterView = UIView(frame: CGRect(x:0.0, y:0.0, width:0.0, height:0.0))
        
        return cell //return the number of cells. quiz question
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


}


//
//  Lights.swift
//  Dashboard
//
//  Created by Saad Durrani on 5/9/18.
//  Copyright © 2018 Khan and Mike Org. All rights reserved.
//

import Foundation

class Lights {
    
    var lightcat:String = ""
    var lightname:String = ""
    var lightdesc:String = ""
    var lightimagename:String = ""
    var lightid:Int32 = 0
    var lighturl:String = ""
    
    init() {
        
    }
}

//
//  SubViewController.swift
//  Dashboard
//
//  Created by Saad Durrani on 5/10/18.
//  Copyright © 2018 Khan and Mike Org. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SubViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlToView:String = (lightOpen.lighturl)
        if urlToView != "" {
            let urlw = URL(string: urlToView)
            let request = URLRequest(url: urlw!)
            webView.load(request)
        }
    }
    
    var lightOpen:Lights = Lights()

}
