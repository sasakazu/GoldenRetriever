//
//  login.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseAuth

class login: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            
            guard let user = authResult?.user else { return }
    
            
         
            
        }
    
        
        
    }
    



}
