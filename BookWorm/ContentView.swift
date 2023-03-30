//
//  ContentView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var bookgenre = 0
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Book genre", selection: $bookgenre) {
                    Text("Fiction").tag(0)
                    Text("Nonfiction").tag(1)
                }
                .pickerStyle(.segmented)
                .colorMultiply(.accentColor)
                .font(.custom("Cairo", size: 15))
                
                List {
                    
                }
                .navigationBarTitle(Text("Bestsellers"), displayMode: .large)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
