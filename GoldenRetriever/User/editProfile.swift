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
    
    
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var dogNameTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNameTF.delegate = self
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["userName"] as? String ?? ""
            let dogname = value?["dogName"] as? String ?? ""
            
            self.userNameTF.text = username
            self.dogNameTF.text = dogname
            
        })
            

        
       
  
    }
    

    @IBAction func update(_ sender: Any) {
        
       if let currentUser = Auth.auth().currentUser {
        
        let userName = userNameTF.text
        let userID = currentUser.uid
        let dogName = dogNameTF.text
        
        let ref = Database.database().reference()
        
        let updateUserInfo = [
            "userName": userName,
            "userID": userID,
//            "userIcon": userID,
            "dogName": dogName
            
        ]
        
        ref.child("users").child((userID)).updateChildValues(updateUserInfo as [AnyHashable : Any])
      
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
