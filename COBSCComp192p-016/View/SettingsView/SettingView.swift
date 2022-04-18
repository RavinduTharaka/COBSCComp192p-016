

import SwiftUI
import Firebase

struct SettingView: View {
    @StateObject private var settingVM = SettingViewModel()
    
    var body: some View {
        ZStack{
            GeometryReader{_ in
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Name")
                            .foregroundColor(Color("Blue"))
                            .font(.caption)
                            .padding(.top, 10)
                            TextField("Name", text: $settingVM.userDetails.name)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color("Blue"), lineWidth: 2)
                            )
                            
                        Text("NIC")
                            .foregroundColor(Color("Blue"))
                            .font(.caption)
                            .padding(.top, 10)
                            TextField("NIC", text: $settingVM.userDetails.nic)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color("Blue"), lineWidth: 2)
                            )
                    }

                    Text("Mobile Number")
                        .foregroundColor(Color("Blue"))
                        .font(.caption)
                        .padding(.top, 10)
                        TextField("Mobile Number", text: $settingVM.userDetails.mobile)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Blue"), lineWidth: 2)
                        )

                    Text("Email")
                        .foregroundColor(Color("Blue"))
                        .font(.caption)
                        .padding(.top, 10)
                        TextField("Email", text: $settingVM.userDetails.email)
                        .disabled(true)
                        .foregroundColor(.gray)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Blue"), lineWidth: 2)
                        )
   
                    Text("Gender")
                        .foregroundColor(Color("Blue"))
                        .font(.caption)
                        .padding(.top, 10)
                        TextField("Gender", text: $settingVM.userDetails.selectedGender)
                        .disabled(true)
                        .foregroundColor(.gray)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Blue"), lineWidth: 2)
                        )

//                    Divider()
//                        .foregroundColor(Color("Blue"))
                        Button {
                            self.settingVM.logout()
                        } label: {
                            Text("Log out")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Blue"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    

                }
                .padding(.horizontal, 25)

            }

            if self.settingVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$settingVM.message.alert, error: self.$settingVM.message.error, topic: self.$settingVM.message.topic, loading: self.$settingVM.message.isLoading, guestUser: $settingVM.message.guestUser)
                }
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    self.settingVM.verify()
                } label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Blue"))
                }

            }
        }
        .background(Color("Yellow"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
