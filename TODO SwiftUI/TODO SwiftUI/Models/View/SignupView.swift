//
//  SignupView.swift
//  TODO SwiftUI
//
//  Created by Melis on 13. 1. 2023..
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State var checked:Bool=false
    @State var email:String=""
    @State var pass:String=""
    var body: some View {
        ZStack{
            Color("Cream")
                .ignoresSafeArea()
            VStack{
                Navigation()
                VStack{
                    Spacer()
                    InputFieldText(text: "Email")
                    InputField(string: $email)
                    InputFieldText(text:"Password")
                    SecureInputField(string: $pass)
                    CheckBox(checked: $checked)
                    SignButton(checked: $checked, email: $email, pass: $pass)
                    GoToLogin()
                    Spacer()
                     }
                }
            }
        }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

struct SignButton: View {
    @State var errorMess:String=""
    @State var errorCode:Bool=false
    @State var errorCreation:Bool=false
    @State var presentMain:Bool=false
    @Binding var checked:Bool
    @Binding var email:String
    @Binding var pass:String
    var body: some View {
        BigButtonsWhite( action: {
            errorMess=Helper.validateInput(email: email, password: pass, checked: checked,code: &errorCode)
            errorCode ? presentMain=false : DBCore.createUser(emailField: email, passwordField: pass) {done in
                errorCreation = !done
                presentMain = done
            }
        }, name: "Sign up")
        .padding(.vertical,20)
        
        .alert(errorMess,isPresented: $errorCode) {
            Button("OK", role: .cancel) { }
        }
        
        .alert("User can not be created",isPresented: $errorCreation) {
            Button("OK", role: .cancel) { }
        }
        
        .fullScreenCover(isPresented: $presentMain){
            HomeView()
        }
    }
}

struct GoToLogin: View {
    @State var presentLogin:Bool=false
    var body: some View {
        SmallButtonsWhite(action:{
            presentLogin.toggle()
        },name:"Log in")
        .fullScreenCover(isPresented: $presentLogin){
            LoginView()
        }
    }
}

struct CheckBox: View {
    @Binding var checked:Bool
    var body: some View {
        AcceptBox(action: {
            checked.toggle()
        }, w:40,h:40, text: "I accept licences and agreement")
    }
}
