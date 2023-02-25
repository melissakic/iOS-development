//
//  LoginUI.swift
//  Exchanger
//
//  Created by Melis on 17. 2. 2023..
//

import SwiftUI

struct LoginUI: View {
    @ObservedObject var LoginVM:LoginViewModel=LoginViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Background(color: "Black")
                VStack{
                    Header(primaryColor: "Caramel", secondaryColor: "Black")
                    Spacer()
                    CustomText(content: "Welcome back!", color: "Caramel", size: 40)
                        .padding(.bottom,100)
                    CustomText(content: LoginVM.message, color: "Caramel", size: 22)
                        .opacity(LoginVM.showMessage)
                    InputField(icon:"envelope.fill",colorScheme:LoginVM.emailError, content: $LoginVM.email)
                        .padding(.vertical,30)
                    Password(colorScheme: LoginVM.passwordError, pass: $LoginVM.password)
                    ForgotPassButton()
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("Caramel"))
                            .frame(width: 200,height: 60)
                        CustomButtonLarge(content:"Login", background: "Caramel", foreground: "Black"){
                            LoginVM.logUser()
                        }
                        .fullScreenCover(isPresented: $LoginVM.presentable){
                            MainUI()
                        }
                    }
                    .padding(.bottom,30)
                    CustomRectangle(height: 110, color: "Caramel")
                }
                .ignoresSafeArea()
            }
        }
    }
}

struct LoginUI_Previews: PreviewProvider {
    static var previews: some View {
        LoginUI()
    }
}

struct CustomText: View {
    let content:String
    let color:String
    let size:CGFloat
    var body: some View {
        Text(content)
            .foregroundColor(Color(color))
            .font(Font.custom(customFont, size: size))
    }
}

struct InputField: View {
    let icon:String
    let colorScheme:String
    @Binding var content:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(colorScheme), lineWidth: 4)
                .foregroundColor(Color(colorScheme))
            HStack{
                TextField("", text: $content)
                    .accentColor(Color(colorScheme))
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading,20)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .font(Font.custom(customFont, size: 20))
                ZStack {
                    Image(systemName: icon)
                        .foregroundColor(Color(colorScheme))
                    .padding(.trailing)
    
                }
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct Password: View {
    let colorScheme:String
    @Binding var pass:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(colorScheme), lineWidth: 4)
                .foregroundColor(Color(colorScheme))
            HStack{
                SecureField("Password",text: $pass)
                    .accentColor(Color(colorScheme))
                    .foregroundColor(Color(colorScheme))
                    .padding(.leading,20)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .font(Font.custom(customFont, size: 20))
                Image(systemName: "key.horizontal.fill")
                    .foregroundColor(Color(colorScheme))
                    .padding(.trailing)
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct ForgotPassButton: View {
    @State var presented:Bool=false
    var body: some View {
        Button("Forgot password?"){
            presented.toggle()
        }
        .fullScreenCover(isPresented: $presented){
            PasswordResetUI()
        }
            .font(Font.custom(customFont, size: 18))
            .foregroundColor(Color("Caramel"))
            .padding(.top)
    }
}

struct Header: View {
    let primaryColor:String
    let secondaryColor:String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            CustomRectangle(height: 100, color: primaryColor)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ZStack {
                    Image(systemName:"arrowshape.backward.fill" )
                        .foregroundColor(Color(secondaryColor))
                    Button(" "){
                        dismiss()
                    }
                }
            }
        }
    }
}
