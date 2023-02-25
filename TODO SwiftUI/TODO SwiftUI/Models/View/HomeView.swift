//
//  HomeView.swift
//  TODO SwiftUI
//
//  Created by Melis on 13. 1. 2023..
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color("Purpur")
                .ignoresSafeArea()
            VStack{
                HomeAvatar()
                goLog()
                goSign()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct HomeAvatar: View {
    var body: some View {
        Image("HomeBCG")
            .resizable()
            .scaledToFit()
            .frame(height: 200,alignment: .center)
            .padding()
    }
}

struct goLog: View {
    var body: some View {
        BigButtonsPurpur(name: "Login",ID:"goToLogin")
            .padding(.vertical,40)
    }
}

struct goSign: View {
    var body: some View {
        BigButtonsPurpur(name: "Sign up",ID:"goToSign")
    }
}
