//
//  SignUpViewModel.swift
//  Exchanger
//
//  Created by Melis on 20. 2. 2023..
//

import Foundation


final class SignUpViewModel:ObservableObject{
    
    @Published var email:String=""
    @Published var password:String=""
    @Published var checked:Bool=false
    @Published var presented:Bool=false
    @Published var clicked:Bool=false
    @Published var message:String="Please wait..."
    @Published var showMessage:CGFloat=0.0
    var emailError:String{
        if(email=="" && clicked){return "Red"}
        else {return "Caramel"}
    }
    var passwordError:String{
        if(password=="" && clicked){return "Red"}
        else {return "Caramel"}
    }
    var checkedError:String{
        if(!checked && clicked){return "Red"}
        else {return "Caramel"}
    }
    var AuthManager:AuthentificationManager=AuthentificationManager.shared
    
    func SignUpUser(){
            message="Please wait..."
            showMessage=1.0
            AuthManager.createNewUser(email: email, password: password){ done in
                if(!done){self.message="Error with registration"}
                    self.presented = done
                    self.clicked = !done
            }
            }
    }
