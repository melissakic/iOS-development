import UIKit

//protocol for passing data back to parent viewcontroller
protocol sendData {
    func passBackData(taskName:String,taskTime:String)
}

class AddTaskViewController: UIViewController{

    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var timeField: UITextField!

    var delegate:sendData?=nil
    
    //assigning delegate once this viewcontroller has been loaded
    override func viewDidLoad() {
        taskField.delegate=self
        timeField.delegate=self
        }
    
    //save button validating for input and sending data back through delegate
    @IBAction func save(_ sender: UIButton) {
        if (taskField.text == ""){
            return Helper.validateForUserInput(task: taskField)
        }
        if (timeField.text == ""){
            return Helper.validateForUserInput(task: timeField)
        }
        if !checkDate(for: timeField.text!){
            let alert=Helper.alertUserForInvalidInput(message: "Invalid date enter in format [HH:MM]")
            self.present(alert, animated: true)
        }
        else {
            delegate?.passBackData(taskName: taskField.text!, taskTime: timeField.text!)
            dismiss(animated: true)}
    }
    
    //cancel button for going back without any result
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func checkDate(for text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$", options: [.caseInsensitive])
        let range = NSRange(location: 0, length: text.count)
        let matches = regex.matches(in: text, options: [], range: range)
        return matches.first != nil
    }
}

//Do not let user to save unless they filled field name and time for task
extension AddTaskViewController:UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {return true}
        else {textField.placeholder="You must type something"
            return false}
    }
}
