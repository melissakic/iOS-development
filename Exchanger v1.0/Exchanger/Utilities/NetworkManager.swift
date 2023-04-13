//
//  NetworkManager.swift
//  Exchanger
//
//  Created by Melis on 21. 2. 2023..
//

import Foundation

final class NetworkManager{
    
    
    func convert(from:String,to:String,amount:String)->Double{
        let semaphore = DispatchSemaphore (value: 0)
        var result=0.0
        let url = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=\(amount)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("wPoBymPMCxgJm7sDKg96qyUGxUl1kpk1", forHTTPHeaderField: "apikey")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                result=self.JSONConvertParser(with: data)
                semaphore.signal()
            }
            task.resume()
        semaphore.wait()
        return result
    }
    
    func getRates(base:String,completion:@escaping ([String:Double])->Void){
        var rates:[String:Double]=[:]
        let url = "https://api.apilayer.com/exchangerates_data/latest?symbols=&base=\(base)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("wPoBymPMCxgJm7sDKg96qyUGxUl1kpk1", forHTTPHeaderField: "apikey")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            rates=self.JSONRatesParser(with: data)
            completion(rates)
        }
        task.resume()
    }
    
    func JSONRatesParser(with:Data)->[String:Double]{
        let decoder=JSONDecoder()
        do{
            let decodedData=try decoder.decode(Rates.self, from: with)
            return decodedData.rates
        }
        catch{
            print(error)
        }
        return [:]
    }


    func JSONConvertParser(with:Data)->Double{
        let decoder=JSONDecoder()
        do{
         let decodedData=try decoder.decode(ConvertData.self, from: with)
            return decodedData.result
        }
        catch{
            print(error)
        }
        return 0.0
    }

    
}
