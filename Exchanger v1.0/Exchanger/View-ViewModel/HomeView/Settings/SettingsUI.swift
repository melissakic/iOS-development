//
//  SettingsUI.swift
//  Exchanger
//
//  Created by Melis on 17. 2. 2023..
//

import SwiftUI

struct SettingsUI: View {
    var body: some View {
        ZStack{
            Background(color: "Caramel")
            VStack{
                Spacer()
                CustomRectangle(height: 110, color: "Black")
            }
            .ignoresSafeArea()
        }
    }
}

struct SettingsUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI()
    }
}
