//
//  Currencies.swift
//  SwiftCurrency
//
//  Created by Tobias Sörensson on 2023-04-13.
//

import Foundation

class Currencies: ObservableObject {
    
    //I should remove Currencys and just download the symbols from fixer. Also, it makes no sense to have the Currency struct when it only handles the symbols. An array will do.
    @Published var currenciesList = [Currency]()
    @Published var latestExchangeRates: LatestExchangeRates?
   
    
    init() {
        fetchExchangeRates()
        
        let filePath = Bundle.main.path(forResource: "currency_list_of_the_world_plain", ofType: "txt");
            let URL = NSURL.fileURL(withPath: filePath!)

            do {
                let file = try String.init(contentsOf: URL)
                //print(file)
                var currencies = file.components(separatedBy: "\n")
                currencies.removeLast()
                print(currencies.count)
                for currency in currencies {
                    currenciesList.append(Currency(countryCode: currency, euroRate: 1.2))
                    print("/" + currenciesList.last!.countryCode + "/")
                }
            } catch  {
                print(error);
            }
   }
    
    //Yeah, well, trying to get exchange rates...
    
    
    func fetchExchangeRates() {
        let accessKey = AccessKey()
      
        let url = URL(string: "https://api.apilayer.com/fixer/latest")!

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(accessKey.key, forHTTPHeaderField: "apikey")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Got data!")
          guard let data = data else {
            print(String(describing: error))
            return
          }
            self.decodeJSON(data: data)
        }
        task.resume()
    }
    
    
    func decodeJSON(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
               latestExchangeRates = try decoder.decode(LatestExchangeRates.self, from: data)
           } catch let error {
               print("Error decoding JSON: \(error)")
           }
    }
    
    func exchange(from: String, to: String, amount: Double) -> String{
        
        print(from, to, String(amount))
        print(latestExchangeRates?.rates?[from] ?? 0.0)
        if let latestExchangeRates,
           let rates = latestExchangeRates.rates,
           let fromBase = rates[from],
           let toRate = rates[to] {
            let baseAmount = amount / fromBase
            let toAmount = baseAmount * toRate
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 4
            formatter.minimumFractionDigits = 4

            guard let string = formatter.string(for: toAmount) else { return "Error!" }
            
            return string
        } else {
            print("Error!")
            return "Error!"
        }
    }
}
