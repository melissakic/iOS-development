//
//  PaswordResetUI.swift
//  Exchanger
//
//  Created by Melis on 18. 2. 2023..
//

import SwiftUI

struct PasswordResetUI: View {
    @ObservedObject var PasswordResetVM:PasswordResetViewModel=PasswordResetViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ZStack{
                Background(color: "Caramel")
                VStack {
                    Header(primaryColor: "Caramel", secondaryColor: "Black")
                    Spacer()
                    CustomText(content: "Forgot password?", color: "Black", size: 40)
                        .padding(.bottom,40)
                    InputField(icon:"envelope.fill",colorScheme: PasswordResetVM.emailError, content: $PasswordResetVM.email)
                    CustomButtonLarge(content: "Send ", background: "Black", foreground: "Caramel"){
                        PasswordResetVM.resetPassword()
                        if(PasswordResetVM.dissmis){dismiss()}
                        else{PasswordResetVM.email=""}
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all)
            }
        }
    }
}

struct PaswordResetUI_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetUI()
    }
}
