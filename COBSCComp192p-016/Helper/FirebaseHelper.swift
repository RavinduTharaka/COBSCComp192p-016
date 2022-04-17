//
//  FirebaseHelper.swift
//  COBSCComp192p-016
//
//  Created by Ravindu Tharaka Ranathunga on 2022-04-10.
//



import SwiftUI
import Firebase
import FirebaseStorage

let storage = Storage.storage().reference()
let metadata = StorageMetadata()

let ref = Firestore.firestore()



func fetchUser(completion: @escaping (UserModel) -> ()){
    let uid = Auth.auth().currentUser!.uid
    ref.collection("Users").document(uid).getDocument{ (doc, err) in
        guard let user = doc else { return }
        
        let dob = user.data()?["dob"] as! String
        let email = user.data()?["email"] as! String
        let gender = user.data()?["gender"] as! String
        let mobile = user.data()?["mobile"] as! String
        let name = user.data()?["name"] as! String
        let nic = user.data()?["nic"] as! String
         
        DispatchQueue.main.async {
            completion(UserModel(dob: dob, email: email, gender: gender, mobile: mobile, name: name, nic: nic))
        }
    }
}
