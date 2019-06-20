//
//  acountMain.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import FirebaseAuth

class acountMain: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.image.layer.cornerRadius = 50.0
        

        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let email = user.email
            let name = user.displayName
            
            userName.text = name
            emailLabel.text = email
            
            
            
            
        }
        
    }



}
