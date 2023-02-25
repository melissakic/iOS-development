//
//  Helper.swift
//  TODO SwiftUI
//
//  Created by Melis on 30. 1. 2023..
//

import Foundation

struct Helper{
    
    static func isvalidEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }

    static func isValidPassword(enteredPassword:String) -> Bool {
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-7]).{7,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: enteredPassword)
    }

    static func validateTask(name:String,time:String)->Bool{
        return (name != "" && time != "")
    }
    
    static func getTime()->String{
        var weekday:String
        var date:String
        let month=Calendar.current.component(.month, from: Date())
              let monthStr=Calendar.current.monthSymbols[month-1]
              let weekdayInt=Calendar.current.component(.weekday, from: Date())
              let weekdayStr=Calendar.current.weekdaySymbols[weekdayInt-1]
              let day="\(Calendar.current.component(.day, from: Date()))th"
              weekday="\(weekdayStr) , "
              date="\(monthStr) \(day)"
            return weekday+date
    }
    
    static func validateInput(email:String,password:String,checked:Bool, code:inout Bool)->String{
        code=true
        if(!checked){ return "Please accept licences and agreement"
        }
        else if(!Helper.isvalidEmail(enteredEmail: email)){return "Invalid email"
        }
        else if(!Helper.isValidPassword(enteredPassword: password)){return "Invalid password"}
        code=false
        return ""
    }

    
    static func validateInputLogin(email:String,password:String)->Bool{
        if(!Helper.isvalidEmail(enteredEmail: email)){return false}
        else if(!Helper.isValidPassword(enteredPassword: password)){return false}
        return true
    }

}
