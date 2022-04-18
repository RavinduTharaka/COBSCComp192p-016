import SwiftUI

struct Register: View {
    @StateObject var locationManager = LocationManagerHelper()
    @StateObject var registerVM = RegisterViewModel()
    @Environment(\.presentationMode) var present
     
    var body: some View {
        ZStack{
            ZStack(alignment: .topLeading, content: {
                GeometryReader{_ in
                    ScrollView{
                        LazyVStack{

                        Text("Register")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding(.top, 15)
                            VStack{
                                    HStack(spacing: 15){
                                        Image(systemName: "paperplane.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color("Blue"))
                                            .cornerRadius(6)
                                        
                                        Text(locationManager.userLati == "0" ? "Geo Location" : "\(locationManager.userLati) , \(locationManager.userLong)")
                                            .padding(.horizontal,10)
                                        
                                        Spacer()
                                    
                                        }
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color("Blue"), lineWidth: 2)
                                        )
                                        .padding(.top, 10)
                            
                                        TextField("NIC(ex: 965432109)", text: self.$registerVM.register.nic)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(self.registerVM.register.nic != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                                            )
                                            .padding(.top, 20)
                                
                                        TextField("Name", text: self.$registerVM.register.name)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(self.registerVM.register.name != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                                            )
                                            .padding(.top, 20)
                                        
                                        DatePicker("DOB", selection: $registerVM.register.dob, in: registerVM.closedRange...Date(), displayedComponents: .date)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(self.registerVM.register.dob.formatted(date: .long, time: .omitted) != Date.init().formatted(date: .long, time: .omitted) ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                                            )
                                            .padding(.top, 20)
                            }

                            
                            HStack(spacing: 15){
                                Text("Select Gender")
                                Spacer()
                                Picker("Gender", selection: $registerVM.register.selectedGender) {
                                    ForEach(registerVM.genderArray, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.selectedGender != "Male." ? Color("Blue") :  Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            HStack(spacing: 15) {
                                Image(systemName: "phone")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Mobile", text: self.$registerVM.register.mobile)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.mobile != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            HStack(spacing: 15) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Email", text: self.$registerVM.register.email)
                                    .textInputAutocapitalization(.never)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.email != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            HStack(spacing: 15){
                                
                                Button {
                                    self.registerVM.visible.toggle()
                                } label: {
                                    Image(systemName: self.registerVM.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }
                                
                                VStack{
                                    if self.registerVM.visible{
                                        TextField("Password", text: self.$registerVM.register.pass)
                                            .textInputAutocapitalization(.never)
                                    }else {
                                        SecureField("Password", text: self.$registerVM.register.pass)
                                            .textInputAutocapitalization(.never)
                                    }
                                }

                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.pass != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            HStack(spacing: 15){
                                Button {
                                    self.registerVM.revisible.toggle()
                                } label: {
                                    Image(systemName: self.registerVM.revisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }
                                
                                VStack{
                                    if self.registerVM.revisible{
                                        TextField("Re-enter Password", text: self.$registerVM.register.repass)
                                            .textInputAutocapitalization(.never)
                                    }else {
                                        SecureField("Re-enter Password", text: self.$registerVM.register.repass)
                                            .textInputAutocapitalization(.never)
                                    }
                                }

                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.repass != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            Button {
                                registerVM.verifyRegistration()
                            } label: {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("Blue"))
                            .cornerRadius(10)
                            .padding(.top, 20)

                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    self.present.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color("Blue"))
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Blue"))
                    }
                }
                .padding()

            })
            if self.registerVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$registerVM.message.alert, error: self.$registerVM.message.error, topic: self.$registerVM.message.topic, loading: self.$registerVM.message.isLoading, guestUser: $registerVM.message.guestUser)
                }
            }
        }
        .background(Color("Yellow"))
        .navigationBarHidden(true)
        .onAppear{
            locationManager.locationManager.delegate = locationManager
        }
    }

}



