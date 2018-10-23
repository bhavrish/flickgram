//
//  postsViewController.swift
//  flickgram
//
//  Created by Bhavesh Shah on 10/22/18.
//  Copyright © 2018 Bhavesh Shah. All rights reserved.
//

import UIKit
import Parse

class postsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var homePageTableView: UITableView!
    
    var imageFiles = [PFFile]()
    var imageText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (posts: [AnyObject]?, Error?) Void in
            
            if error == nil {
                for post in posts! {
                    self.imageFiles.append(post["imageFile"] as! PFFile)
                    self.imageText.append(post["imageText"] as! String)
                }
                
                self.homePageTableView.reloadData()
            }
            
            else {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageFiles.count
    } // Method for how many rows in tableview.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.captionLabel.text = imageText[indexPath.row]
    
        imageFiles[indexPath.row].getDataInBackground { (imageData: NSData?, error: Error?) -> Void in
            if imageData != nil {
                let image = UIImage(data: imageData!)
                singleCell.posterImageView.image = image
            }
            else {
                print(error)
            }
        }
        
        return cell
    }

}
