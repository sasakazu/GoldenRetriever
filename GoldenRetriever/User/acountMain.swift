//
//  acountMain.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase



class acountMain: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var dogNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.image.layer.cornerRadius = 50.0
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in
           
            let value = snapshot.value as? NSDictionary
            let username = value?["userName"] as? String ?? ""
            let dogname = value?["dogName"] as? String ?? ""
            print("usernameは、\(username)")
            
          self.userName.text = username
          self.dogNameLabel.text = dogname
            
            
        })
        
            
        { (error) in
            print(error.localizedDescription)
        }
    
        
    }
    
  
   
    
    
    
    
    
    
}
