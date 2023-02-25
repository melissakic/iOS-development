//
//  File.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import Foundation

final class SymbolViewModel:ObservableObject{
    @Published var searchText:String=""
    
    init(searchText: String="") {
        self.searchText = searchText
    }
    
    var searchResults: [String:String] {
           if searchText.isEmpty {
               return ABC
           } else {
               return ABC.filter { $0.key.contains(searchText) }
           }
       }
}
