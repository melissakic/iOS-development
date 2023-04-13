//
//  SymbolsUI.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import SwiftUI

struct SymbolsUI: View {
    @ObservedObject var SymbolsVM:SymbolViewModel=SymbolViewModel()
    var body: some View {
        ZStack{
            Background(color: "Caramel")
            VStack{
                InputField(icon: "magnifyingglass", colorScheme: "Black", content: $SymbolsVM.searchText)
                ScrollView{
                    ForEach(SymbolsVM.searchResults.sorted(by: <),id: \.key){a,b in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 4)
                            HStack{
                                CustomText(content: "\(a) - \(b)", color: "Black", size: 18)
                            }
                            .padding(.vertical)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .searchable(text:$SymbolsVM.searchText)
                Spacer()
                CustomRectangle(height: 110, color: "Black")
            }
            .ignoresSafeArea()
            .padding(.top)
        }
    }
}

struct SymbolsUI_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsUI()
    }
}
