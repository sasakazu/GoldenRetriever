//
//  collectionView.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/16.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class collectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var messageArray = [Post]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        let ref = Database.database().reference()

        let userID = Auth.auth().currentUser?.uid
        
        ref.child("posts").observe(.value) { (snap) in
            
            
            let postDictionary = snap.value as? NSDictionary
            
      
            print(postDictionary)
            
            if postDictionary != nil {
                
            
            
                for(p) in postDictionary! {
                
                let posts = p.value as? NSDictionary
                
                
               guard let username = posts?.value(forKey: "userName") else {return}
               guard let postImage = posts?.value(forKey: "images") else {return}
               let newPost = Post(username: username as? String ?? "", postImage: postImage as? String ?? "")

                self.messageArray.append(newPost)
                
                print(newPost.postImage)
                
                self.collectionView.reloadData()

                self.collectionView.delegate = self
                self.collectionView.dataSource = self
            
            
            }
                
            }
            
            else {
                
                print("error")
            }
            
            
        }
       
        
     
    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! customCell
        

       cell.userName.text = messageArray[indexPath.row].username
        
        


        let url = NSURL(string: (messageArray[indexPath.row].postImage) as String)

        cell.postImage.sd_setImage(with: url as URL?)
        

        return cell
        
        
    }
 
    
 
    
    
    
}
