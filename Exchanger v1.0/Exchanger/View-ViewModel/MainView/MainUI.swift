//
//  MainUI.swift
//  Exchanger
//
//  Created by Melis on 19. 2. 2023..
//

import SwiftUI

struct MainUI: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(cgColor: .init(gray: 20, alpha: 0.5))
    }
    var body: some View {
        TabView {
            ExchangeRatesUI().tabItem {
                Image(systemName: "dollarsign")
            }
            CalculatorUI().tabItem {
                Image(systemName: "arrow.left.arrow.right")
            }
            SymbolsUI().tabItem {
                Image(systemName: "abc")
            }
        }
        .accentColor(Color("Caramel"))
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI()
    }
}
