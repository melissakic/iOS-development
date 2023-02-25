//
//  SignupViewController.swift
//  TODO list
//
//  Created by Melis on 11. 12. 2022..
//

import UIKit
import FirebaseAuth
import CLTypingLabel

class SignupViewController: UIViewController,UITextViewDelegate{
    
    var accepted:Bool=false
    @IBOutlet weak var pleaseWait: UILabel!
    @IBOutlet weak var dots: CLTypingLabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var checkedBox: UIImageView!
    @IBOutlet weak var box: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func goToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: false)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "logInVC") as? LoginViewController {
                show(viewController, sender: self)
            }
    }
    //check license box
    @IBAction func licenceBox(_ sender: UIButton) {
        if checkedBox.alpha==0{
            checkedBox.alpha=1
            accepted=true
        }
        else {
            accepted=false
            checkedBox.alpha=0
        }
    }
    
    //sign up logic
    @IBAction func signUp(_ sender: UIButton) {
        Helper.resetBorderStyle(task1: emailField, task2: passwordField)
        if (emailField.text == ""){
            return Helper.validateForUserInput(task: emailField)
        }
        if (passwordField.text == ""){
            return Helper.validateForUserInput(task: passwordField)
        }
        if !Helper.isvalidEmail(enteredEmail: emailField.text!) {
            let alert=Helper.alertUserForInvalidInput(message: "Email is not valid")
            self.present(alert, animated: true, completion: nil)
            emailField.text=""
            emailField.becomeFirstResponder()
            return
        }
        if !Helper.isValidPassword(enteredPassword: passwordField.text!) {
            let alert=Helper.alertUserForInvalidInput(message: "Password is not valid.Must contain >6 characters,upper case,lower case and number")
            self.present(alert, animated: true, completion: nil)
            passwordField.text=""
            passwordField.becomeFirstResponder()
            return
        }
        if !accepted {
            let alert=Helper.alertUserForInvalidInput(message: "You must accept license and agreemnt")
            self.present(alert, animated: true, completion: nil)
            return
        }
        Helper.presentLoading(dots: dots,pleaseWait: pleaseWait)
        createUser(emailField: emailField, passwordField: passwordField)
        
    }
    
    //send email for verification
    func sendEmailForVer(user:User?) {
        if let safeUser=user{
            safeUser.sendEmailVerification { error in
                if let _ = error{
                    let alert=Helper.alertUserForInvalidInput(message: "Can not send email for verification")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //create user
    func createUser(emailField:UITextField,passwordField:UITextField){
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if let _=error{
                let alert=Helper.alertUserForInvalidInput(message: "User can not be registered email taken")
                self.present(alert, animated: true, completion: nil)
                Helper.clearLoading(dots: self.dots, pleaseWait: self.pleaseWait)
                return
            }
            else {
                let User = Auth.auth().currentUser
                self.sendEmailForVer(user: User)
                Helper.clearLoading(dots: self.dots,pleaseWait: self.pleaseWait)
                self.navigationController?.popToRootViewController(animated: true)}
                self.dismiss(animated: false)
        }
    }
    
}
