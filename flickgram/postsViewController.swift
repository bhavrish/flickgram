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
    
    // code to move to post page
    @IBAction func onPost(_ sender: Any) {
        performSegue(withIdentifier: "postSegue", sender: nil)
    }
    
    
    var imageFiles = [PFFile]()
    var imageText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageTableView.delegate = self
        homePageTableView.dataSource = self
        
        fetchPostData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // code for fetching data
    func fetchPostData() {
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (posts, error) in
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageFiles.count
    }

    // code for setting elements in tableview to specific valuse from the database
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.captionLabel.text = imageText[indexPath.row]
    
        imageFiles[indexPath.row].getDataInBackground { (data, error) -> Void in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                cell.posterImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }

}
