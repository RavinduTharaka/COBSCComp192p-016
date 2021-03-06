//
//  RegisterViewModel.swift
//  COBSCComp192p-016
//
//  Created by Ravindu Tharaka Ranathunga on 2022-04-16.
//


import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    var locationManager = LocationManagerHelper()
    @Published var register : RegisterModel
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    @Published var genderArray = ["Male", "Female", "Other"]
    @Published var closedRange = Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    @Published var visible = false
    @Published var revisible = false
    @AppStorage("current_status") var status = false

    let ref = Firestore.firestore()
    
    init(){
        register = RegisterModel(nic: "", name: "", dob: Date(), selectedGender: "Male.", mobile: "", email: "", pass: "", repass: "", geoLocation: "\(self.locationManager.userLati),\(self.locationManager.userLong)")
    }
    
    func verifyRegistration(){
  
        if self.register.nic != "" && self.register.name != "" && self.register.dob.formatted(date: .long, time: .omitted) != Date.init().formatted(date: .long, time: .omitted) && self.register.selectedGender != "Male." && self.register.mobile != "" && self.register.email != "" && self.register.pass != "" && self.register.repass != "" {
            if self.register.nic.isValidNIC{
                if  self.register.mobile.isValidContact {
                    if self.register.pass == self.register.repass {
                        createNewAccount()
                    }else{
                            self.message.error = "Password mismatch"
                            self.message.alert.toggle()
                    }
                }else{
                    self.message.error = "Invalid Phone Number"
                    self.message.alert.toggle()
                }
            }else{
                self.message.error = "Invalid NIC ID"
                self.message.alert.toggle()
            }
        } else {
            self.message.error = "Please Fill the all the Fields properly"
            self.message.alert.toggle()
        }
    }

    
    func createNewAccount(){
        self.message.alert.toggle()
        self.message.isLoading = true
        Auth.auth().createUser(withEmail: self.register.email, password: self.register.pass) { (res , err)  in
            if err != nil {
                self.message.isLoading = false
                self.message.error = err!.localizedDescription
            }else{
                let uid = res?.user.uid
                self.ref.collection("Users").document(uid!).setData([
                    "uid" : uid,
                    "nic" : self.register.nic,
                    "name" :self.register.name,
                    "dob" : self.register.dob.formatted(date: .long, time: .omitted),
                    "gender" : self.register.selectedGender,
                    "mobile" : self.register.mobile,
                    "email" : self.register.email,
                    "geoLocation": self.register.geoLocation,
                    "dateCreated" : Date.init()
                    
                ]) { (err) in
                    if err != nil {
                        self.message.isLoading = false
                        self.message.error = err!.localizedDescription
                    }else{
                        self.message.isLoading = false
                        self.message.topic = "Success"
                        self.message.error = "Registered Successfully"
                        self.register = RegisterModel(nic: "", name: "", dob: Date(), selectedGender: "Male.", mobile: "", email: "", pass: "", repass: "", geoLocation: "\(self.locationManager.userLati),\(self.locationManager.userLong)")
                    }
                }
            }
        }
    }
}





