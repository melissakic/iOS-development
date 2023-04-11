

import Foundation

final class ExcangeRatesViewModel:ObservableObject{
    var Rates:NetworkManager=NetworkManager()
    @Published var source:String=""
    
    func conversion(completion:@escaping ([String:Double])->Void){
        Rates.getRates(base: source){data in
            completion(data);
            
        }
    }
}
