//
//  LoginView.swift
//  TODO SwiftUI
//
//  Created by Melis on 13. 1. 2023..
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email:String=""
    @State var pass:String=""
    var body: some View {
        ZStack{
                Color("Cream")
                .ignoresSafeArea()
            VStack{
                Navigation()
                Spacer()
                InputFieldText(text: "Email")
                InputField(string: $email)
                InputFieldText(text:"Password")
                SecureInputField(string: $pass)
                LoginButton(email: $email, pass: $pass)
                GoToSign()
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginButton: View {
    @State var presentMain:Bool=false
    @State var errorVerification:Bool=false
    @State var errorLogin:Bool=false
    @Binding var email:String
    @Binding var pass:String
    var body: some View {
        BigButtonsWhite(action: {
            Helper.validateInputLogin(email: email, password: pass) ?
            DBCore.LoginAndVerify(emailField: email, passwordField: pass){done in
                errorLogin = !done
                presentMain = done
            } : errorVerification.toggle()
        }, name: "Login")
        .alert("Invalid input try again",isPresented: $errorVerification) {
            Button("OK",role: .cancel){}
        }
        .alert("Log in error,check if you verified your mail,or registerd",isPresented:$errorLogin ){
            Button("OK",role: .cancel){}
        }
        .fullScreenCover(isPresented: $presentMain){
            MainView()
        }
        .padding(.vertical,20)
    }
}

struct GoToSign: View {
    @State var presentSignup:Bool=false
    var body: some View {
        SmallButtonsWhite(action:{
            presentSignup.toggle()
        },name:"Sign up")
        .fullScreenCover(isPresented: $presentSignup){
            SignupView()
        }
    }
}





