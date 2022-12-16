import Foundation
import UIKit
import CLTypingLabel

//Simple two value struct
struct ToDoElementsModel{
    let name:String
    let time:String
}

struct Helper{
    //function for setting up date and weekday for home page
    static func displayHomePageDateInfo(date:UILabel,weekday:UILabel){
        let month=Calendar.current.component(.month, from: Date())
        let monthStr=Calendar.current.monthSymbols[month-1]
        let weekdayInt=Calendar.current.component(.weekday, from: Date())
        let weekdayStr=Calendar.current.weekdaySymbols[weekdayInt-1]
        let day="\(Calendar.current.component(.day, from: Date()))th"
        weekday.text="\(weekdayStr) , "
        date.text="\(monthStr) \(day)"
    }
    
    //func to warn users to enter task name and time
    static func validateForUserInput(task:UITextField){
        task.becomeFirstResponder()
        task.placeholder="Can not be empty"
        task.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        task.layer.borderWidth = 1.0
    }

    //func to reset border styles
    static func resetBorderStyle(task1:UITextField,task2:UITextField){
        task1.layer.borderWidth = 0.0
        task2.layer.borderWidth = 0.0
        
    }
    
    //email validate
    static func isvalidEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }

    //pass validate
    static func isValidPassword(enteredPassword:String) -> Bool {
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-7]).{7,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: enteredPassword)
    }

    //alert popup
    static func alertUserForInvalidInput(message:String) -> UIAlertController{
        let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    //loading
    static func presentLoading(dots:CLTypingLabel!,pleaseWait:UILabel){
        pleaseWait.alpha=1
        dots.alpha=1
        dots.text=". . . . . . . . . ."
    }

    //clear loading
    static func clearLoading(dots:CLTypingLabel!,pleaseWait:UILabel){
        pleaseWait.alpha=0
        dots.text=""
        dots.alpha=0
    }
}

