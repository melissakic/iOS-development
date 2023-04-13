//
//  CalculatorUI.swift
//  Exchanger
//
//  Created by Melis on 19. 2. 2023..
//

import SwiftUI

struct CalculatorUI: View {
    @ObservedObject var CalculatorVM:CalculatorViewModel=CalculatorViewModel()
    var body: some View {
        ZStack{
            Background(color: "Caramel")
            VStack{
                Spacer()
                CustomText(content: "Convert currency!", color: "Black", size: 35)
                Spacer()
                Image(systemName: "arrow.left.arrow.right")
                    .resizable()
                    .frame(width: 90,height: 110)
                Spacer()
                HStack {
                    Selector(color: CalculatorVM.fromError, selected: "Convert from", choice: $CalculatorVM.from, options: symbols)
                    Selector(color: CalculatorVM.toError, selected: "Convert to", choice: $CalculatorVM.to, options: symbols)
                }
                .padding(.all)
                InputField(icon: "arrow.backward", colorScheme: CalculatorVM.inputError, content: $CalculatorVM.amount)
                    .keyboardType(.decimalPad)
                InputField(icon: "arrow.forward", colorScheme: "Black", content: $CalculatorVM.result)
                    .disabled(true)
                    .padding(.bottom,60)
                CustomButtonLarge(content: "Convert", background: "Black", foreground: "Caramel"){
                    CalculatorVM.convert()
                }
                    .padding(.bottom,30)
                CustomRectangle(height: 110, color: "Black")
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CalculatorUI_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorUI()
    }
}
