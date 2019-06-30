//
//  User.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/25.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import Foundation



class User{
    
    var username: String = ""
    var email:String = ""
    var uid:String = ""
    var postId:String = ""


    init(username: String, email:String, postId:String, uid:String) {
        
        self.username = username
        self.email = email
        self.postId = postId
        self.uid = uid
        
        
    }
    
    

}



