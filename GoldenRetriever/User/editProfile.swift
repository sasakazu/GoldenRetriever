//
//  editProfile.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseAuth

class editProfile: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let name = user.displayName
           
            nameTF.placeholder = name
            
            
        }
        
        
        

    }
    
    
    @IBAction func update(_ sender: Any) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = nameTF.text
        
        changeRequest?.commitChanges { (error) in
           
        }
        
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

}
