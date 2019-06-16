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

class addPhoto: UIViewController, UITextFieldDelegate {
    
   
    @IBOutlet weak var contentTF: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTF.delegate = self
        
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser {
        
            
        let userID = currentUser.uid
        let userName = currentUser.displayName
//        let userIcon = currentUser.photoURL
//        let userImages = currentUser.photoURL
        let comment = contentTF.text
        
       
        let ref = Database.database().reference().child("post")
        
        let data = [
            "userID": userID,
            "userName": userName,
            "userIcon": userID,
            "images": userID,
            "content": comment
            
            ]
        
        ref.childByAutoId().setValue(data)
        
  
         self.navigationController?.popToRootViewController(animated: true)
        
        }
 
    }
    
    
    
}
