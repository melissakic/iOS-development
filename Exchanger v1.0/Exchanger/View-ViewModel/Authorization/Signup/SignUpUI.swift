//
//  SignUpUI.swift
//  Exchanger
//
//  Created by Melis on 17. 2. 2023..
//

import SwiftUI

struct SignUpUI: View {
    @ObservedObject var SignUpVM:SignUpViewModel=SignUpViewModel()
    var body: some View {
        ZStack{
            Background(color: "Black")
            VStack{
                    CustomRectangle(height: 100, color: "Caramel")
                    CustomText(content: "Join Us!", color: "Caramel", size: 40)
                    .padding(.top,50)
                    Spacer()
                CustomText(content: SignUpVM.message, color: "Caramel", size: 24)
                    .opacity(SignUpVM.showMessage)
                InputField(icon: "envelope.fill", colorScheme: SignUpVM.emailError, content: $SignUpVM.email)
                        .padding(.vertical)
                Password(colorScheme: SignUpVM.passwordError, pass: $SignUpVM.password)
                        .padding(.bottom)
                    Toggle(isOn: $SignUpVM.checked) {
                        CustomText(content: "I accept license agreement", color:SignUpVM.checkedError, size: 22)
                                .padding(.leading)
                        }
                        .padding(.trailing)
                        .toggleStyle(SwitchToggleStyle(tint: Color("Caramel")))
                        .padding(.horizontal)
                    Spacer()
                    CustomButtonLarge(content: "Sign Up", background: "Caramel", foreground: "Black"){
                        SignUpVM.SignUpUser()
                    }
                    .fullScreenCover(isPresented: $SignUpVM.presented){
                        HomeUI()
                    }
                        .padding(.bottom,30)
                    CustomRectangle(height: 110, color: "Caramel")
                }
            }
            .ignoresSafeArea()
    }
}

struct SignUpUI_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUI()
    }
}
