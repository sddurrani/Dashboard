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
        
        let imgURL = URL(string:(destValue?.lightimagename)!)
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        lightImage?.image = img
        lightImage?.contentMode = .scaleAspectFill
        lightImage!.layer.cornerRadius = 0
        lightImage!.clipsToBounds = true
        
        /*
        let imgURL = URL(string: "helios.vse.gmu.edu/~sdurran2/dash/" + (destValue?.lightname)!)
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        lightImage?.image = img
        lightImage?.contentMode = .scaleAspectFill
        lightImage!.layer.cornerRadius = 0
        lightImage!.clipsToBounds = true
         */
        
        /*
        let imgURL = URL(string: "https://api.myjson.com/bins/1dxtga" + (destValue?.lightname)!)
        let dataBytes = try? Data(contentsOf: imgURL!)
        let img = UIImage(data: dataBytes!)
        lightImage?.image = img
        lightImage?.contentMode = .scaleAspectFill
        lightImage!.layer.cornerRadius = 0
        lightImage!.clipsToBounds = true
         */
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

