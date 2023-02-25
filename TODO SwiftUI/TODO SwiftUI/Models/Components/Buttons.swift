import SwiftUI

struct BigButtonsPurpur: View {
    @State var clicked:Bool=false
    let name:String
    let ID:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:100)
                .frame(width: 200, height: 80, alignment: .center)
                .foregroundColor(.white)
            Button(name){
                clicked.toggle()
            }
            .fullScreenCover(isPresented: $clicked){
                if (ID=="goToLogin"){
                    LoginView()
                }
                else if(ID=="goToSign"){
                    SignupView()
                }
            }
                .foregroundColor(Color("Purpur"))
                .font(Font.custom("Gill Sans", size: 28))
        }
        
    }
}

struct BigButtonsWhite: View {
    let action: () -> Void
    let name:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 300, height: 90, alignment: .center)
                .foregroundColor(Color("Purpur"))
            Button(name){
                action()
            }
            .foregroundColor(.white)
                .font(Font.custom("Gill Sans", size: 30))
        }
        
    }
}

struct SmallButtonsWhite: View {
    let action: () -> Void
    let name:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 200, height: 60, alignment: .center)
                .foregroundColor(Color("Purpur"))
            Button(name){
                action()
            }
                .foregroundColor(.white)
                .font(Font.custom("Gill Sans", size: 30))
        }
        
    }
}


struct Navigation: View {
    @State var showingSheet=false
    var body: some View {
        HStack {
            Button(" "){
                showingSheet.toggle()
            }
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding()
            .fullScreenCover(isPresented: $showingSheet){
                HomeView()
            }
            .background(Image("Home")
                .resizable()
                .frame(width: 30, height: 30)
            )
            Spacer()
        }
    }
}


struct AcceptBox: View {
    let action:()->Void
    let w:CGFloat
    let h:CGFloat
    let text:String
    @State public var checked=false
    @State var img:String="square"
    var body: some View {
        HStack{
            ZStack{
                Image(systemName:img)
                    .resizable()
                    .frame(width: w,height: h)
                    .foregroundColor(Color("Purpur"))
                Button(" "){
                    checked.toggle()
                    img=(checked ? "checkmark.square" : "square")
                    action()
                }
                .frame(width: 20,height: 20)
            }
            Text(text)
                .foregroundColor(Color("Purpur"))
                .font(Font.custom("Gill Sans", size: 20))
        }
        .padding(.vertical,20)
    }
}
