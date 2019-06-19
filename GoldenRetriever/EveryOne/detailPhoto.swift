//
//  detailPhoto.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/19.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class detailPhoto: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image:UIImage = getImageByUrl(url:"https://firebasestorage.googleapis.com/v0/b/goldenretriever-e26c7.appspot.com/o/images%2F65JdmK9mNMXmBcmIzRHli3hnv172__582627375203.jpg?alt=media&token=b762ed22-36a4-4d09-8452-a48aef2740c8")
        
        imageView.image = image

    
}


    @IBAction func button(_ sender: Any) {
        
        

    }
    
        
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
    

