//
//  collectionView.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/16.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class collectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var messageArray = [Any]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        if Auth.auth().currentUser != nil {
            let postsRef = Database.database().reference().child("post")
            
            postsRef.observe(.childAdded, with: { snapshot in
                
                if let _ = Auth.auth().currentUser?.uid {
                    let dictionary = snapshot.value as! [String: AnyObject]
    
                    
                    
                    self.messageArray.insert(dictionary, at: 0)
                    self.collectionView.reloadData()
                }
            })
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
        
        
        let cell = collectionView.dequeueReusableCell (
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! customCell
        
        let dictionary = messageArray[indexPath.row] as! [String: AnyObject]
        
        
        cell.userName.text = dictionary["userName"] as? String
            
        cell.contents.text = dictionary["content"] as? String
        
 
//        cell.postImage.image = dictionary["images"] as? UIImage
        
            
 
        
      
        
        return cell
        
        
    }
 

}
