
import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct MainView: View {
    @State var Alltasks:[tasks]=[]
    @State var clicked:Bool=false
    var body: some View {
            ZStack{
                Background()
                    VStack{
                        Navigation()
                        DiplayDate()
                        Spacer()
                        if(Alltasks.isEmpty)
                        {Color("Cream")}
                        else
                        {ListOfTasks(Alltasks: $Alltasks)}
                        Footer(clicked: $clicked, Alltasks: $Alltasks)
                    }
                }
            .onAppear{
                DBCore.loadTasks(){fetched in
                    if let safeFetch=fetched{Alltasks+=safeFetch}
                    else{print("error")}
                }}
            }
        }


struct AddView: View {
    @State var taskName:String=""
    @State var taskTime:String=""
    @Binding var Alltasks:[tasks]
    @Environment(\.presentationMode) var pm
    var body: some View {
        ZStack{
            Background()
            VStack{
                InputFieldText(text: "Task name")
                InputField(string: $taskName)
                InputFieldText(text: "Task time")
                InputField(string: $taskTime)
                    .padding(.bottom,30)
                Save(taskName: $taskName, taskTime: $taskTime, Alltasks: $Alltasks)
                Cancel()
            }
        }
    }
}

struct DateTime: View {
    var body: some View {
        Text(Helper.getTime())
            .font(Font.custom("Gill Sans", size: 30))
            .foregroundColor(Color("Purpur"))
            .padding(.top,10)
    }
}

struct CustomText: View {
    let text:String
    let size:CGFloat
    var body: some View {
        Text(text)
            .foregroundColor(Color("Purpur"))
            .font(Font.custom("Gill Sans", size: size))
    }
}


struct Background: View {
    var body: some View {
        Color("Cream")
            .ignoresSafeArea(.all)
    }
}


struct ListRow: View {
    @Binding var Alltasks:[tasks]
    let temp:tasks
    @Binding var task:tasks
    var body: some View {
        HStack{
            AcceptBox(action: {
                task.hide.toggle()
            },w:25,h:25, text: " ")
            if(!task.hide){
                CustomText(text: task.taskName, size: 21)
                Spacer()
                CustomText(text: task.taskTime, size: 20)
            }
            else{
                CustomText(text: task.taskName, size: 21)
                    .strikethrough(true, color: Color("Purpur"))
                Spacer()
            }
        }
        .onDisappear{
            DBCore.deleteFromDB(name: temp.taskName,time: temp.taskTime){done in
                if (!done) {
                    Alltasks.append(tasks(taskName: task.taskName, taskTime: temp.taskTime))
                }
            }
        }
        .listRowBackground(Color("Cream"))
        .listRowSeparator(.visible, edges: .top)
    }
}

struct DiplayDate: View {
    var body: some View {
        DateTime()
            .padding(.bottom,10)
    }
}

struct ListOfTasks: View {
    @Binding var Alltasks:[tasks]
    var body: some View {
        List($Alltasks,id: \.self.id,editActions: .all) {$task in
            ListRow(Alltasks: $Alltasks, temp: task, task: $task)
        }
        .background(Color("Cream"))
        .scrollContentBackground(.hidden)
        .foregroundColor(Color("Purpur"))
    }
}

struct Footer: View {
    @Binding var clicked:Bool
    @Binding var Alltasks:[tasks]
    var body: some View {
        HStack{
            Text(String(Alltasks.count))
                .font(Font.custom("Gill Sans", size: 25))
                .foregroundColor(Color("Purpur"))
            Text("Tasks")
                .font(Font.custom("Gill Sans", size: 25))
                .foregroundColor(Color("Purpur"))
            Spacer()
            Button("ADD NEW +"){
                clicked.toggle()
            }
            .fullScreenCover(isPresented: $clicked){
                AddView(Alltasks: $Alltasks)
            }
            .font(Font.custom("Gill Sans", size: 24))
            .foregroundColor(Color("Purpur"))
        }
        .padding(.horizontal,30)
        .padding(.top,30)
        .padding(.bottom,15)
    }
}

struct Save: View {
    @Binding var taskName:String
    @Binding var taskTime:String
    @State var errorInput:Bool=false
    @State var errorDB:Bool=false
    @Binding var Alltasks:[tasks]
    @Environment(\.presentationMode) var pm
    var body: some View {
        BigButtonsWhite(action: {
            if (Helper.validateTask(name: taskName, time: taskTime)){
                DBCore.saveDataInDtabase(name: taskName, time: taskTime){done in
                    if (done) {
                        Alltasks.append(tasks(taskName: taskName, taskTime: taskTime))
                        pm.wrappedValue.dismiss()
                    }
                    else{
                        errorDB.toggle()}
                }
            }
            else{
                errorInput.toggle()
            }
        }, name: "Save")
        .alert("Invalid input",isPresented: $errorInput){
            Button("OK",role: .cancel){}
        }
        .alert("Database error",isPresented: $errorDB){
            Button("OK",role:.cancel){}
        }
    }
}

struct Cancel: View {
    @Environment(\.presentationMode) var pm
    var body: some View {
        SmallButtonsWhite(action:{
            pm.wrappedValue.dismiss()
        },name: "Cancel")
    }
}


