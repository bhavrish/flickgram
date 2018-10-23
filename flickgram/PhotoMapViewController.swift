//
//  PhotoMapViewController.swift
//  flickgram
//
//  Created by Bhavesh Shah on 10/22/18.
//  Copyright © 2018 Bhavesh Shah. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var uploadMessage: UITextField!
    @IBOutlet weak var postUploadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onChooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImageView.image = image
        }
        else {
            print("Problem getting the chosen image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postOnTap(_ sender: Any) {
        var imageText = uploadMessage.text
        
        if chosenImageView.image == nil {
            print("Image not uploaded")
        }
        else {
            var posts = PFObject(className: "Posts")
            posts["imageText"] = imageText
            posts["uploader"] = PFUser.current()
            posts.saveInBackground(block: {(success: Bool, error: Error?) -> Void in
                if error == nil {
                    var imageData = UIImagePNGRepresentation(self.chosenImageView.image!)
                    var parseImageFile = PFFile(name: "upload_image.png", data: imageData!)
                    posts["imageFile"] = parseImageFile
                    posts.saveInBackground(block: {(success: Bool, error: Error?) -> Void in
                        if error == nil {
                            print("data uploaded")
                            self.postUploadingLabel.text = "Post Uploaded"
                        }
                        else {
                            print(error)
                        }
                    })
                }
                    
                else {
                    print(error)
                }
            
            })
        }
    }
    
}
