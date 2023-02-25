//
//  AuthorizationUI.swift
//  Exchanger
//
//  Created by Melis on 17. 2. 2023..
//

import SwiftUI

struct AuthorizationUI: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(cgColor: .init(gray: 20, alpha: 0.5))
    }
    var body: some View {
        NavigationStack{
            TabView {
                LoginUI()
                .ignoresSafeArea()
                .tabItem {
                    Image(systemName: "person.fill")
                }
                SignUpUI().tabItem {
                    Image(systemName: "person.fill.badge.plus")
                }
            }
            .accentColor(.black)
        }
    }
}

struct AuthorizationUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationUI()
    }
}
