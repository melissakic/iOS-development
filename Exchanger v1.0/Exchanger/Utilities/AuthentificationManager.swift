import FirebaseAuth


final class AuthentificationManager{
    var currentEmail:String?=nil
    
    public static var shared=AuthentificationManager()
    
    func createNewUser(email:String,password:String,completion:@escaping (Bool)->Void){
        if(!Validators.validateEmail(email: email)){completion(false)}
        else if(!Validators.validatePassword(password: password)){completion(false)}
        else{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil{
                    completion(false)
                }
                else{
                    self.currentEmail=authResult?.user.email
                    completion(true)
                }
            }
        }
    }
    
    func logInUser(email:String,password:String,completion:@escaping (Bool)->Void){
        if(email==""){completion(false)}
        else if(password==""){completion(false)}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil{
                completion(false)
            }
            else{
                self?.currentEmail=authResult?.user.email
                completion(true)
            }
        }
    }
    
    func resetPass(email:String,completion:@escaping (Bool)->Void){
        if(email==""){completion(false)}
        else{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil{
                    completion(false)
                }
                else{
                    completion(true)
                }
            }
        }
    }
}
