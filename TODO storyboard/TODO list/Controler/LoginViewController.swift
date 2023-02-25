import UIKit
import FirebaseAuth
import CLTypingLabel

class LoginViewController: UIViewController {

    @IBOutlet weak var pleaseWait: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dots: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func goToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: false)
    }
    
    @IBAction func goToSignup(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "signUpVC") as? SignupViewController {
                show(viewController, sender: self)
            }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Helper.resetBorderStyle(task1: emailField, task2: passwordField)
        if (emailField.text == ""){
            return Helper.validateForUserInput(task: emailField)
        }
        if (passwordField.text == ""){
            return Helper.validateForUserInput(task: passwordField)
        }
        passwordField.endEditing(true)
        if !Helper.isvalidEmail(enteredEmail: emailField.text!) {
            let alert=Helper.alertUserForInvalidInput(message: "Email is not valid")
            self.present(alert, animated: true, completion: nil)
            emailField.text=""
            emailField.becomeFirstResponder()
            return
        }
        emailField.endEditing(true)
        Helper.presentLoading(dots: dots,pleaseWait: pleaseWait)
        LoginAndVerify(emailField: emailField, passwordField: passwordField)
    }
    
    //login and verify for input parameters
    func LoginAndVerify(emailField:UITextField,passwordField:UITextField){
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
            guard self != nil else { return }
            if let _=error {
                let alert=Helper.alertUserForInvalidInput(message: "You entered invalid information")
                self?.present(alert, animated: true, completion: nil)
                Helper.clearLoading(dots: self!.dots, pleaseWait: self!.pleaseWait)
                return
            }
            let user=Auth.auth().currentUser
            if !user!.isEmailVerified{
                let alert=Helper.alertUserForInvalidInput(message: "Verify your email to log in")
                self?.present(alert, animated: true, completion: nil)
                Helper.clearLoading(dots: self!.dots, pleaseWait: self!.pleaseWait)
                return
            }
            self!.performSegue(withIdentifier: "goToMain", sender: self)
            Helper.clearLoading(dots: self?.dots,pleaseWait:self!.pleaseWait)
        }
    }
}
