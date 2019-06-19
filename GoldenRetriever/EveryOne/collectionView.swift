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
        
        let urll = dictionary["images"] as? String
        
        
        let image:UIImage = getImageByUrl(url: urll!)
        
        cell.postImage.image = image
        
        
        return cell
        
        
    }
 
    
//    URLから画像に変換する

    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
    
    
}
