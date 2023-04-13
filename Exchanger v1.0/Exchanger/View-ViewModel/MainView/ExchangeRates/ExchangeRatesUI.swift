//
//  ExchangeRatesUI.swift
//  Exchanger
//
//  Created by Melis on 19. 2. 2023..
//

import SwiftUI

struct ExchangeRatesUI: View {
    @ObservedObject var ExchangeRatesVM=ExcangeRatesViewModel()
    @State var loading=0.0
    @State var arr:[String:Double]=[:]
        var body: some View {
        ZStack{
            Background(color: "Caramel")
            VStack{
                    Spacer()
                    HStack{
                        Selector(color: "Black", selected: "Choose currency", choice: $ExchangeRatesVM.source, options: symbols)
                    }
                    .padding(.all)
                    CustomRectangle(height: 10, color: "Black")
                    ZStack {
                        CustomText(content: "Choose currency and hit the button(default is EUR).\nFetching may take a while", color: "Black", size: 23)
                            .opacity(loading)
                        ScrollView{
                            ForEach(arr.sorted(by: <),id: \.key){a,b in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.black,lineWidth: 3)
                                    HStack{
                                        CustomText(content: a, color: "Black", size: 25)
                                            .padding(.leading)
                                        Spacer()
                                        Text("\(b)")
                                            .padding(.trailing)
                                            .foregroundColor(Color("CurrencyBuy"))
                                    }
                                }
                            }
                            .padding(.all)
                        }
                    }
                    CustomRectangle(height: 10, color: "Black")
                    CustomButtonLarge(content: "Get rates!", background: "Black", foreground: "Caramel", action: {
                        loading=1.0
                        arr=[:]
                        ExchangeRatesVM.conversion(){data in
                            loading=0.0
                            arr=data
                            
                        }
                    })
                    Spacer()
                    CustomRectangle(height: 110, color: "Black")
                }
                .padding(.top)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ExchangeRatesUI_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRatesUI()
    }
}

struct Selector: View {
    let color:String
    @State var selected:String
    @Binding var choice:String
    let options:[String]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(color), lineWidth: 3)
            Menu(selected) {
                ForEach(options,id: \.self){symbol in
                    Button(symbol){
                        selected=symbol
                        choice=symbol
                    }
                }
            }
            .foregroundColor(Color(color))
            .font(Font.custom(customFont, size: 21))
        }
        .frame(height: 40)
    }
}
