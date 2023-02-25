//
//  DBCore.swift
//  TODO SwiftUI
//
//  Created by Melis on 31. 1. 2023..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct DBCore{
    
    static func saveDataInDtabase(name:String,time:String,completion:@escaping(Bool)->Void){
        let db=Firestore.firestore()
        let email=Auth.auth().currentUser?.email
        db.collection(email!).addDocument(data: ["taskName":name,"taskTime":time]) { error in
            if let _ = error {
                completion(false)
            }
            else{completion(true)}
        }
    }


    static func loadTasks(completion:@escaping([tasks]?)->Void){
        var values:[tasks]=[]
        let db=Firestore.firestore()
        let email=Auth.auth().currentUser?.email
        db.collection(email!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print(err)
                completion(nil)
            } else {
                for document in querySnapshot!.documents {
                    values.append(tasks(taskName: document.data()["taskName"]! as! String, taskTime: document.data()["taskTime"]! as! String))
                }
                completion(values)
            }
        }
    }

    static func deleteFromDB(name:String,time:String,completion:@escaping(Bool)->Void){
        let db=Firestore.firestore()
        let email=Auth.auth().currentUser?.email
        db.collection(email!).whereField("taskName", isEqualTo: name).whereField("taskTime", isEqualTo: time)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                    completion(true)
                }
        }
    }

    
    static func sendEmailForVer(user:User?)->Bool{
        var confirmation:Bool=true
            if let safeUser=user{
                safeUser.sendEmailVerification { error in
                    if let _ = error{
                        confirmation=false
                    }
                }
            }
            return confirmation
        }
        

   static func createUser(emailField:String,passwordField:String,completion:@escaping(Bool)->Void){
            Auth.auth().createUser(withEmail: emailField, password: passwordField) { authResult, error in
                if let _=error{
                    completion(false)
                }
                else{
                    let User = Auth.auth().currentUser
                    completion(sendEmailForVer(user: User))
                }
            }
        }

    static func LoginAndVerify(emailField:String,passwordField:String,completion:@escaping(Bool)->Void){
        Auth.auth().signIn(withEmail: emailField, password: passwordField) {authResult, error in
            if let _=error {
                completion(false)
            }
            else{
                let user=Auth.auth().currentUser
                if !user!.isEmailVerified{
                    completion(false)
                }
                else{completion(true)}
            }
        }
    }
}
