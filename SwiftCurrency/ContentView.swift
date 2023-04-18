//
//  ContentView.swift
//  SwiftCurrency
//
//  Created by Tobias Sörensson on 2023-04-13.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var currencies = Currencies()
    @State var selectedCurrencyFrom = "EUR"
    @State var selectedCurrencyTo = "SEK"
    @State var amount = "0.0"
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Convert from:")
            Picker("Please choose a currency to convert from:", selection: $selectedCurrencyFrom) {
                ForEach(currencies.currenciesList, id: \.self.countryCode) { currency in
                    Text(currency.countryCode)
                }
            }
            Text("To:")
            Picker("Please choose a currency to convert to:", selection: $selectedCurrencyTo) {
                ForEach(currencies.currenciesList, id: \.self.countryCode) {currency in
                    Text(currency.countryCode)
                }
            }
            
            Spacer()
            Text("Amount to convert:")
            TextField("Amount to convert:", text: $amount)
                .multilineTextAlignment(.center)
            Text("\(amount) \(selectedCurrencyFrom) equals \(currencies.exchange(from: selectedCurrencyFrom, to: selectedCurrencyTo, amount: Double(amount) ?? 0.0)) \(selectedCurrencyTo)")
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
