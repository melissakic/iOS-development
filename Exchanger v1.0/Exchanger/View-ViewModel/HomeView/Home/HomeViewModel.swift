

import Foundation

final class HomeViewModel:ObservableObject{
    @Published var presentable:Bool=false
    
    func goToLogin(){
        presentable.toggle()
    }
}
