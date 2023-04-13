//
//  LoginViewModel.swift
//  Exchanger
//
//  Created by Melis on 20. 2. 2023..
//

import Foundation


final class LoginViewModel:ObservableObject{
    @Published var email:String=""
    @Published var password:String=""
    @Published var clicked:Bool=false
    @Published var message:String="Please wait..."
    @Published var showMessage:CGFloat=0
    var emailError:String{
        if(email=="" && clicked) {return "Red"}
        else {return "Caramel"}
    }
    var passwordError:String{
        if(password=="" && clicked) {return "Red"}
        else {return "Caramel"}
    }
    @Published var presentable:Bool=false
    var AuthManager:AuthentificationManager=AuthentificationManager.shared
    
    
    func logUser(){
        clicked=true
        message="Please wait"
        showMessage=1.0
        AuthManager.logInUser(email: email, password: password){done in
            if(!done){
                self.showMessage=1.0
                self.message="Error with authentification!"
            }
            else{
                self.presentable = done
                self.clicked = !done
            }
        }
    }
}
