import Foundation


final class Validators{
    static func validateEmail(email:String)->Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    static func validatePassword(password:String)->Bool{
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-7]).{7,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
