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
    
    let ref = Database.database().reference()
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var friend1TF: UITextField!
    @IBOutlet weak var firiendTF2: UITextField!
    
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        guard let text = nameTF.text else { return }
  
        self.ref.child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue(["user": (Auth.auth().currentUser?.uid)!,"content": text, "date": ServerValue.timestamp()])
        
        self.navigationController?.popToRootViewController(animated: true)
        
   
 
    }
    
    
    
}
