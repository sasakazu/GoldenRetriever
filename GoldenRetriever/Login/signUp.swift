//
//  signUp.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class signUp: UIViewController, UITextFieldDelegate {
    
 
    
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.userName.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self

    }
    
    


    

    @IBAction func sigunup(_ sender: Any) {
        
        let userName = self.userName.text
        let email = emailTF.text
        let password = passwordTF.text
        
        let ref = Database.database().reference()
        
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            
            let newUser = [
                "newUser": userName,
                "email": email,
                "userID": user?.user.uid
            
            ]
            
                        if error == nil {
            
                            ref.child("users").child(((user?.user.uid)!)).setValue(newUser)
            
                        } else {
            
                         print("error")
                            
                            
                        }
            
                    }
        
       
        
        
        
    }
    

        
    
    //    returnキーで閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userName.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        return true
        
    }
    

}
