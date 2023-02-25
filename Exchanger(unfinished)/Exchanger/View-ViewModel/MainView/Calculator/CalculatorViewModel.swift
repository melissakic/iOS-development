//
//  CalculatorViewModel.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import Foundation

final class CalculatorViewModel:ObservableObject{

    
    var Converter:NetworkManager=NetworkManager()
    @Published var from:String=""
    @Published var to:String=""
    @Published var amount:String=""
    @Published var result:String=""
    @Published var clicked:Bool=false
    var inputError:String {
        if(amount=="" && clicked){return "Red"}
        else {return "Black"}
    }
    var fromError:String{
        if(from=="" && clicked){return "Red"}
        else {return "Black"}
    }
    var toError:String{
        if(to=="" && clicked){return "Red"}
        else {return "Black"}
    }
    
    func convert(){
        clicked=true
        if(amount==""||from==""||to==""){
            return
        }
        else{
            result=String(Converter.convert(from: from, to: to, amount: amount))
        }
        }
}
