//
//  ExchangeRatesViewModel.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import Foundation

final class ExcangeRatesViewModel:ObservableObject{
    var Rates:NetworkManager=NetworkManager()
    @Published var source:String=""
    @Published var rates:[String:Double]=[:]
    @Published var loading:Double=0.0
    
    func conversion(){
        loading=1.0
        rates=Rates.getRates(base: source){rates in
            
            self.loading=0.0
        }
    }
}
