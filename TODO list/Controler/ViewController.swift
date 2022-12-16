import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController{
    
    @IBOutlet weak var TasksCount: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array:[ToDoElementsModel]=[]
    var paths:[String:String]=[:]
    var newTaskName:String?=nil
    var newTaskTime:String?=nil
    let db = Firestore.firestore()
    
    //configuring data for cells and display home screen date
    override func viewDidLoad() {
        loadTasks()
        super.viewDidLoad()
        Helper.displayHomePageDateInfo(date: dateLabel, weekday: weekdayLabel)
        tableView.dataSource=self
        tableView.delegate=self
        }

    //call for child segue

    @IBAction func AddTask(_ sender: UIButton) {
        performSegue(withIdentifier: "goTo", sender: self)
    }
    //declare cild viewcontroler as delegate for passing back data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goTo"{
            let drugi=segue.destination as! AddTaskViewController
            drugi.delegate = self
        }
    }

    //edit tasks
    @IBAction func editing(_ sender: Any) {
        changeEditingmode(tableView: tableView)
    }
    
    //change editing mode
    func changeEditingmode(tableView:UITableView){
        if tableView.isEditing {
            tableView.isEditing=false;
        }
        else {

            tableView.isEditing=true;
        }
    }
    
    //save tasks to database
    func saveDataInDtabase(Name:String,Time:String){
        let email=Auth.auth().currentUser?.email
        let a=db.collection("task").addDocument(data: [email!:[Name,Time,""]]) { error in
            if let _ = error {
                let alert = Helper.alertUserForInvalidInput(message: "Error with database storing")
                self.present(alert, animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        db.collection("task").document(createpath(path: a.path)).setData([email!:[Name,Time,createpath(path: a.path)]])
        paths[createString(n: Name, t: Time)]=createpath(path: a.path)
    }
    
    //crate path
    func createpath(path:String)->String{
        let fInd=path.firstIndex(of: "/")
        let str=path[fInd!...]
        return String(str)
    }
    
    //create string for paths
    func createString(n:String,t:String)->String{
        return "\(n),\(t)"
    }
    
    
    //delete from database
    func deleteFromDb(name:String,time:String){
        db.collection("task").document(paths[createString(n: name, t: time)]!).delete()
//        let email=Auth.auth().currentUser?.email
//        db.collection("task").getDocuments { (querySnapshot, error) in
//                if let er = error {
//                    print(er)
//                } else {
//                    for document in querySnapshot!.documents {
//                        let doc=document.data() as! [String:[String]]
//                        if(doc==[email!:[name,time]]){
//                            document.reference.delete()
//                        }
//                    }
//                }
//            }
    }
    
    //load loged user tasks from database
    func loadTasks(){
        let email=Auth.auth().currentUser?.email
        array=[]
            db.collection("task").getDocuments { QuerySnapshot, error in
            if let _ = error {
                let alert = Helper.alertUserForInvalidInput(message: "Error with database fetch")
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if let document = QuerySnapshot?.documents {
                    for Entry in document {
                        if let safeEntry=Entry.data()[email!] {
                           let task=safeEntry as! [String]
                            self.array.append(ToDoElementsModel(name: task[0], time: task[1]))
                            self.tableView.insertRows(at: [IndexPath.init(row: self.array.count-1, section: 0)], with: .automatic)
                            self.paths[self.createString(n: task[0], t: task[1])]=task[2]
                        }
                    }
                }
            }
            self.tableView.reloadData()
            self.TasksCount.text = String(Int(self.array.count))
        }
    }
    
}



//defining delegate function for retrieving data
extension ViewController:sendData{
    func passBackData(taskName: String, taskTime: String) {
       newTaskName=taskName
       newTaskTime=taskTime
        array.append(ToDoElementsModel(name: newTaskName!, time: newTaskTime!))
        tableView.insertRows(at: [IndexPath.init(row: array.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
        TasksCount.text = String(Int(TasksCount.text!)!+1)
        saveDataInDtabase(Name: newTaskName!, Time: newTaskTime!)
    }
}

//configuring cell UI and behaviour
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Stavka",for: indexPath) as! CustomCell
        cell.CellName.text = array[indexPath.row].name
        cell.CellTime.text = array[indexPath.row].time
        cell.selectionStyle = .none
        return cell
    }
    

}

//moving cells
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteFromDb(name: array[indexPath.row].name, time: array[indexPath.row].time)
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.reloadData()
            TasksCount.text=String(Int(TasksCount.text!)!-1)
        }
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

