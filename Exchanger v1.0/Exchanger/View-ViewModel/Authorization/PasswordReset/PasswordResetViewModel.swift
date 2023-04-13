//
//  PasswordResetViewModel.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import Foundation

final class PasswordResetViewModel:ObservableObject{
    
    @Published var email:String=""
    @Published var clicked:Bool=false
    @Published var dissmis:Bool=false
    var emailError:String{
        if(email=="" && clicked) {return "Red"}
        else {return "Black"}
    }
    var AuthManager:AuthentificationManager=AuthentificationManager.shared
    
    
    func resetPassword(){
        clicked=true
        AuthManager.resetPass(email: email){error in
            self.dissmis=error
        }
    }
}
