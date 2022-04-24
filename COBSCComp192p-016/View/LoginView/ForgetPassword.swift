import SwiftUI

struct ForgetPassword: View {
    @StateObject var forgetPassVM = ForgetPasswordViewModel()
    @Environment(\.presentationMode) var present
     
    var body: some View {
        ZStack{
            ZStack(alignment: .topLeading, content: {
                GeometryReader{_ in
                    VStack{
                        Text("Forget Password")
                              .font(.title)
                              .fontWeight(.bold)
                              .foregroundColor(Color.black.opacity(0.7))
                              .padding(.top, 15)
                        Image("forgetBG")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3)
                        Text("Reset My password")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.7))
                        HStack(spacing: 15) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color.black.opacity(0.7))
                            TextField("Email", text: self.$forgetPassVM.login.email)
                                .textInputAutocapitalization(.never)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.forgetPassVM.login.email != "" ? Color("Blue") : Color.black.opacity(0.7), lineWidth: 2)
                        )
                        .padding(.top, 25)
                        
                        Button {
                            self.forgetPassVM.verifyResetPassword()
                        } label: {
                            Text("Reset Password")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Blue"))
                        .cornerRadius(10)
                        .padding(.top, 25)

                    }
                    .padding(.horizontal, 25)
                }
                
                Button {
                    self.present.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color("Blue"))
                    }
                }
                .padding()


            })
            
            if self.forgetPassVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$forgetPassVM.message.alert, error: self.$forgetPassVM.message.error, topic: self.$forgetPassVM.message.topic, loading: self.$forgetPassVM.message.isLoading, guestUser: $forgetPassVM.message.guestUser)
                }
            }
        }
        .background(Color("Yellow"))
        .navigationBarHidden(true)
    }
    
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
    }
}
