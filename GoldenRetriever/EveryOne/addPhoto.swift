//
//  addPhoto.swift
//  GoldenRetriever
//
//  Created by 笹倉一也 on 2019/06/14.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class addPhoto: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    

    
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTF.delegate = self
        imageView.layer.cornerRadius = 10.0
        postBtn.layer.cornerRadius = 5.0
        
        
        
        
    }
    
    
    @IBAction func camera(_ sender: Any) {
        
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
           
            
        }
    }
    
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
 
            imageView.image = pickedImage
            
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
    
    
    
    
    @IBAction func albun(_ sender: Any) {
        
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

    @IBAction func saveBtn(_ sender: Any) {
   
        
            SVProgressHUD.show()
            
            var imageData = Data()
            
            let storage = Storage.storage()
            
            let storageRef = storage.reference(forURL: "gs://goldenretriever-e26c7.appspot.com/")
        
           let userID = Auth.auth().currentUser?.uid
            
            
        let riversRef = storageRef.child("images/" + (userID!) +  "__\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
            
            let image = imageView.image

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
                    
        
                let ref = Database.database().reference()
            
                    
               let userRef = ref.child("users").child(userID!)
                
                
                userRef.observeSingleEvent(of: .value, with:  { (snapshot) in

                let dictionaly = snapshot.value as? NSDictionary
                    
              
                
                let username = dictionaly?["userName"] as? String ?? ""
//                let dogname = dictionaly?["dogName"] as? String ?? ""
                let userIcon = dictionaly?["userIcon"] as? String ?? ""
                
                    
                let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyyMMddHH:mm"

                    
                let dateString = dateFormatter.string(from: Date())
               
                
                    
                let userID = userID
                let userName = username
                let deta = downloadURL.absoluteString
                let comment = self.contentTF.text
                let icon = userIcon
                let postDate = dateString
                let likeCount = 0


                let data = [
                    "userID": userID!,
                            "userName": userName,
                            "userIcon": icon,
                            "images": deta,
                            "content": comment as Any,
                            "date": postDate,
                            "likeCount": likeCount
                    
                    ] as [String : Any]

                    ref.child("posts").child(userID!).childByAutoId().setValue(data as [AnyHashable : Any])


                        })


        print("成功！")

    SVProgressHUD.showSuccess(withStatus: "Success")


    self.navigationController?.popToRootViewController(animated: true)





                }

            }
    
    
        }

                
    
//    returnキーで閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        contentTF.resignFirstResponder()
       
        return true
        
    }

    

    
    
 
    
    
    
}
