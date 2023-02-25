//
//  Text.swift
//  TODO SwiftUI
//
//  Created by Melis on 19. 1. 2023..
//

import SwiftUI

struct InputFieldText: View {
    let text:String
    var body: some View {
        Text(text)
            .foregroundColor(Color("Purpur"))
            .font(Font.custom("Gill Sans", size: 30))
    }
}

