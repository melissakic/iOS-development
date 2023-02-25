//
//  InputFields.swift
//  TODO SwiftUI
//
//  Created by Melis on 19. 1. 2023..
//

import SwiftUI


struct InputField: View {
    @Binding var string:String
    var body: some View {
        TextField(text: $string){}
            .padding(.horizontal, 50.0)
            .padding(.vertical,20.0)
            .border(.black, width: 0.2)
            .cornerRadius(200)
            .font(.system(size: 25))
            .multilineTextAlignment(.center)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}

struct SecureInputField: View {
    @Binding var string:String
    var body: some View {
        SecureField(text: $string){}
            .padding(.horizontal, 50.0)
            .padding(.vertical,20.0)
            .border(.black, width: 0.2)
            .cornerRadius(200)
            .font(.system(size: 25))
            .multilineTextAlignment(.center)
    }
}


