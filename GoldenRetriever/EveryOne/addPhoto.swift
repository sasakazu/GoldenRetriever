//
//  addPhoto.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseStorage

class addPhoto: UIViewController, UITextFieldDelegate {
    
    var ref:DatabaseReference?
    
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTF.delegate = self
        
        
        let image = UIImage(named: "fff")
        
        imageView.image = image
        
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser {
            
            
            
            var imageData = Data()
            
            let storage = Storage.storage()
            
            let storageRef = storage.reference(forURL: "gs://goldenretriever-e26c7.appspot.com/")
            
            
            let riversRef = storageRef.child("images/" + (currentUser.uid) +  "__\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
            
            let image = imageView.image


            
            imageData = (image?.jpegData(compressionQuality: 1.0))!
            
            
            _ = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                
                riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    

        
            
        let userID = currentUser.uid
        let userName = currentUser.displayName
        let deta = downloadURL.absoluteString

                    
        let comment = self.contentTF.text
        
       
        let ref = Database.database().reference().child("post")
        
        let data = [
            "userID": userID,
            "userName": userName,
            "userIcon": userID,
            "images": deta,
            "content": comment
            
            ]
        
        ref.childByAutoId().setValue(data)
        
  
         self.navigationController?.popToRootViewController(animated: true)
        
        }
 

    
    
            }
            
        }
        
    }




}
