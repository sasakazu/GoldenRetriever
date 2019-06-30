//
//  acountMain.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class acountMain: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate {
 
    var myFeed = [Post]()
    
    var ref: DatabaseReference!
   

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    

    
    
    
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
            let userIcon = value?["userIcon"] as? String ?? ""

//            print("usernameは、\(username)")

          self.userName.text = username
          self.dogNameLabel.text = dogname

          let url = NSURL(string: (userIcon) as String)
          self.image.sd_setImage(with: url as URL?)
            
            
        })
        


        ref.child("posts").child(userID!).observe(.childAdded) { (snap) in
        
            guard let dict = snap.value as? [String: Any] else { return }
            
            
            guard let memoString = dict["userName"] as? String else { return }
            guard let date = dict["images"] as? String else { return }
            
             guard let getid = dict["userID"] as? String else { return }

            let newPost = Post(username: memoString, postImage: date,getUid: getid)
            
            self.myFeed.append(newPost)
            

                    self.collectionView.reloadData()



            }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        


    }
  
   

   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myFeed.count
    
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! myCustomCell
        
        
        let url = NSURL(string: (myFeed[indexPath.row].postImage) as String)
        
        cell.myImageView.sd_setImage(with: url as URL?)
        
        
        return cell
        
    }
    


    

    
}
