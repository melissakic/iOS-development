
import SwiftUI

struct HomeUI: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(cgColor: .init(gray: 20, alpha: 0.5))
    }
    @ObservedObject var HomeVM:HomeViewModel=HomeViewModel()
    var body: some View {
        TabView{
            ZStack{
               Background(color: "Caramel")
                VStack{
                    LogoText()
                        .padding(.trailing,20)
                    Spacer()
                    CustomButtonLarge(content: "Login", background: "Black", foreground: "Caramel"){
                        HomeVM.goToLogin()
                    }
                    .fullScreenCover(isPresented: $HomeVM.presentable){
                        AuthorizationUI()
                    }
                    .padding(.bottom,30)
                    CustomRectangle(height: 110, color: "Black")
                }
                .ignoresSafeArea()
            }
                .tabItem
            {
              Image(systemName: "house.fill")
            }
            SettingsUI().tabItem
            {
              Image(systemName: "gearshape.fill")
            }
        }
        .accentColor(Color("Caramel"))
    }
}

struct HomeUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeUI()
    }
}

struct Background: View {
    let color:String
    var body: some View {
        Color(color)
            .ignoresSafeArea()
    }
}

struct CustomRectangle: View {
    let height:CGFloat
    let color:String
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(Color(color))
    }
}

struct LogoText: View {
    var body: some View {
        Image("LogoText")
            .resizable()
            .frame(width: 380,height: 380)
            .padding(.top,120)
        
    }
}

struct CustomButtonLarge: View {
    let content:String
    let background:String
    let foreground:String
    let action:()->Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(background))
            Button(content){
                action()
            }
                .foregroundColor(Color(foreground))
                .font(Font.custom(customFont, size: 25))
        }
        .frame(height: 60)
        .padding(.horizontal,10)
    }
}

