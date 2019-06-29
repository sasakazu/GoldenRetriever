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
    
    var postRefHandle: DatabaseHandle!
    var ref: DatabaseReference!
   
//    var handle: UInt!
//    var updateHandler: UInt!

//    override func loadView() {
//        remove()
//    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)


//        removestop()




        }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
//        removestop()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
        
//removestop()
        
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        removestop()
   

        self.image.layer.cornerRadius = 50.0
        
    
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        
    

        ref.child("users").child(userID!).observeSingleEvent(of:.value, with: { (snapshot) in
     
           
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
        
//        self.removestop()

        ref.child("posts").child(userID!).observeSingleEvent(of:.value) { (snap) in
        
            print(snap)
//            self.removestop()
            
            
            let postDictionary = snap.value as? NSDictionary
            
    
                
                
            for p in postDictionary! {
                    
                    
                    
                    let posts = p.value as? NSDictionary
                    
                    
                    guard let username = posts?.value(forKey: "userName") else {return}
                    guard let postImage = posts?.value(forKey: "images") else {return}
                    let newPost = Post(username: username as? String ?? "", postImage: postImage as? String ?? "")
                    
                    self.myFeed.append(newPost)
               
//                    print(postImage)
                
                
                
                
                
                
                
                
                    
                    self.collectionView.reloadData()
                    
                }


            
         
            
            }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
//        removestop()

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
    
    
    
//    func removestop() {
//
//
//        ref = Database.database().reference()
//        let userID = Auth.auth().currentUser?.uid
//        ref.child("posts").child(userID!).removeAllObservers(withHandle: self.postRefHandle)
//
//    }

    

    
}
