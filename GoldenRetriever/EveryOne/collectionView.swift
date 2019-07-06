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
        
     
        
        ref.child("users").observeSingleEvent(of: .value) { (snap) in
            
            for item in snap.children {
            
                let snapdata = item as! DataSnapshot
                //１つのデータ
//                print(snapdata)
                let item = snapdata.value as! [String:Any]
    
                
                let getid = item["userID"] as? String
                
//                print("id:::\(getid)")
                
                
             let postRef = Database.database().reference()
                
                postRef.child("posts").child(getid!).observe(.childAdded) { (snapshot) in
                
                
                    
                    guard let dict = snapshot.value as? [String: Any] else { return }
                    
//                    print(dict)
                    

           
                    
                    
                    guard let memoString = dict["userName"] as? String else { return }
                    guard let date = dict["images"] as? String else { return }
                    
                    guard let getid = dict["userID"] as? String else { return }
                    
                     guard let userIcon = dict["userIcon"] as? String else { return }
                    
                    let newPost = Post(username: memoString, postImage: date,getUid: getid,userIcon: userIcon)
                    
                    self.messageArray.append(newPost)
                    
               
                    self.collectionView.reloadData()
                
                }
                
               
                
                
                

            }



        
  

        
    }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
     
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
        

        let postImageUrl = NSURL(string: (messageArray[indexPath.row].postImage) as String)

        cell.postImage.sd_setImage(with: postImageUrl as URL?)
      
        let userIconUrl = NSURL(string: (messageArray[indexPath.row].userIcon) as String)
        
        cell.userIcon.sd_setImage(with: userIconUrl as URL?)
        
        cell.userIcon.layer.cornerRadius = 30.0

        
  
        return cell
        
        
    }
 
    
 
    
    
    
}
