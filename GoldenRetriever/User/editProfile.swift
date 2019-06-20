//
//  editProfile.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseAuth

class editProfile: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let name = user.displayName
           
            nameTF.text = name
            
            
        }
        
        
        

    }
    
    
    @IBAction func update(_ sender: Any) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = nameTF.text
        
        changeRequest?.commitChanges { (error) in
           
        }
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    //    returnキーで閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTF.resignFirstResponder()
        
        return true
        
    }
    

}
