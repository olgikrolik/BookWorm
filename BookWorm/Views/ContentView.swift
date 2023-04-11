//
//  ContentView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bestsellersManager = BestsellersManager()
    @State private var bookgenre = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Book genre", selection: $bookgenre) {
                    Text("Fiction").tag(0)
                    Text("Nonfiction").tag(1)
                }
                .pickerStyle(.segmented)
                .colorMultiply(.accentColor)
                .font(.custom("Cairo-Light", size: 15))
                
                HStack {
                    Button {
                        print("left button was tapped")
                    } label: {
                        Image(systemName: "arrowtriangle.backward")
                    }
                    
                    Label("April 9, 2023", image: "")
                        .font(.custom("Cairo-Light", size: 13))
                    
                    Button {
                        print("right button was tapped")
                    } label: {
                        Image(systemName: "arrowtriangle.forward")
                    }
                    
                }
                
                List(bestsellersManager.booksData) { book in
                    HStack {
                        Text(String(book.rank))
                        
                        VStack {
                            Text(String(book.title))
                            Text(String(book.author))
                            Text(String(book.description))
                        }
                    }
                }
                .navigationBarTitle(Text("Bestsellers"), displayMode: .large)
                }
            }
            .padding()
            .onAppear {
                self.bestsellersManager.fetchData()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
