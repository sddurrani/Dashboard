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
        let jsonURLString = "https://api.myjson.com/bins/17owb2"
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
        
        let imgURL = URL(string:object.lightimagename)
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        cell.imageView?.image = img
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView!.layer.cornerRadius = 0
        cell.imageView!.clipsToBounds = true
        
        //Add the images. Keeping the code for reference.
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

