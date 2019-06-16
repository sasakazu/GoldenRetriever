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
    
   
    @IBOutlet weak var nameTF: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTF.delegate = self
        
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser {
            
        let message = nameTF.text
        
        let id = currentUser.uid
        
        let ref = Database.database().reference().child("post")
        
        let data = [
            "content": message,
            "userID": id,
            "photo": currentUser.email]
        
        ref.childByAutoId().setValue(data)
        
  
         self.navigationController?.popToRootViewController(animated: true)
        
        }
 
    }
    
    
    
}
