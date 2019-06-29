//
//  editProfile.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase


class editProfile: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var dogNameTF: UITextField!
    @IBOutlet weak var userIcon: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNameTF.delegate = self
        
        let image = UIImage(named: "fff")
        userIcon.image = image
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["userName"] as? String ?? ""
            let dogname = value?["dogName"] as? String ?? ""
            
            self.userNameTF.text = username
            self.dogNameTF.text = dogname
            
            
         
                
            
        })
            

        
       
  
    }
    
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            userIcon.image = pickedImage
            
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            
        }
        else{
            
        }
    }
    
    
    
    @IBAction func chosePicture(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            
        }
        else{
            
            
        }
        
        
    }
    

    @IBAction func update(_ sender: Any) {
        
        var imageData = Data()
        
        let storage = Storage.storage()
        
        let storageRef = storage.reference(forURL: "gs://goldenretriever-e26c7.appspot.com/")
        
        let userID = Auth.auth().currentUser?.uid
        
        
        let riversRef = storageRef.child("users/\(String(describing: userID)).jpg")
        
        let image = userIcon.image
        
        imageData = (image?.jpegData(compressionQuality: 1.0))!
        
        
        _ = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                
                return
            }
            
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
            
                
        
        
        
       if let currentUser = Auth.auth().currentUser {
        
        let userName = self.userNameTF.text
        let userID = currentUser.uid
        let dogName = self.dogNameTF.text
        let iconData = downloadURL.absoluteString
        
        let ref = Database.database().reference()
        
        let updateUserInfo = [
            "userName": userName,
            "userID": userID,
            "userIcon": iconData,
            "dogName": dogName
            
        ]
        
        ref.child("users").child((userID)).updateChildValues(updateUserInfo as [AnyHashable : Any])
      
                }
                 self.navigationController?.popViewController(animated: true)
            }
        
    }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
        
        let next: UIViewController = storyboard?.instantiateViewController(withIdentifier: "login") as! login
        present(next, animated: true, completion: nil)
        
        
    }
    
    
    
    //    returnキーで閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        dogNameTF.resignFirstResponder()
        
        return true
        
    }
    

    }
    

