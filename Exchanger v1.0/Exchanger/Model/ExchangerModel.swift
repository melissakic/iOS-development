final class ExchangerModel:Equatable,Hashable{
    var countryImg:String="flag.fill"
    var countyName:String="unknown"
    var currnecySell:Double=0.0
    var currencyBuy:Double=0.0
    
    init(img:String,name:String,currSell:Double,currBuy:Double) {
        self.countryImg=img
        self.countyName=name
        self.currnecySell=currSell
        self.currencyBuy=currBuy
    }
    
    public static func ==(lhs:ExchangerModel,rhs:ExchangerModel)->Bool{
        return ObjectIdentifier(lhs)==ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
             hasher.combine(ObjectIdentifier(self))
        }
}

struct ConvertData:Decodable{
    let result:Double
}

struct Currencies:Decodable{
    let symbols:[String:String]
}

struct Rates:Decodable{
    let rates:[String:Double]
}
