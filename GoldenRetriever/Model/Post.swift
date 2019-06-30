//
//  Post.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/25.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import Foundation


class Post{
    
    var username: String = ""
    var postImage:String = ""
    var postId:String = ""
    var getUid:String = ""
    
    
    init(username: String, postImage: String, getUid:String) {
        
        self.username = username
        self.postImage = postImage
        self.getUid = getUid
        
        
    }
    
}


