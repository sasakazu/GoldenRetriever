//
//  editProfile.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase


class editProfile: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dogNameTF: UITextField!
    
    
    var ref:DatabaseReference?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNameTF.delegate = self
       
        fetch()
  
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

        fetch()

    }
    
    
    
    
    func fetch() {
     
   
        
    }
    
    
    @IBAction func update(_ sender: Any) {
        
       if let currentUser = Auth.auth().currentUser {
        
        let userName = currentUser.displayName
        let userID = currentUser.uid
        let dogName = dogNameTF.text
        
        let userInfo = [
            "userName": userName,
            "userID": userID,
            "userIcon": userID,
            "dogName": dogName
            
        ]
        
        let ref = Database.database().reference().child("users").child(userID)
        
        ref.updateChildValues(userInfo)
      
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
        
        let next: UIViewController = storyboard?.instantiateViewController(withIdentifier: "login") as! login
        present(next, animated: true, completion: nil)
        
        
    }
    
    
    
    //    returnキーで閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        dogNameTF.resignFirstResponder()
        
        return true
        
    }
    

}
