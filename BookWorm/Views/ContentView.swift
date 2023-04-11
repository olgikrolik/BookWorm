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
                        .padding()
                        .font(.custom("Cairo-Light", size: 13))
                    
                    Button {
                        print("right button was tapped")
                    } label: {
                        Image(systemName: "arrowtriangle.forward")
                    }
                    
                }
                
                List(bestsellersManager.booksData) { book in
                    HStack {
                        VStack {
                            Text(String(book.rank))
                                .foregroundColor(.accentColor)
                                .font(.custom("Cairo-Light", size: 36))
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(String(book.title))
                                .font(.custom("Cairo", size: 17))
                            Text("by \(book.author)")
                                .font(.custom("Cairo-Light", size: 15))
                            Text(String(book.description))
                                .font(.custom("Cairo", size: 13))
                        }
                        
                        Spacer()
                        AsyncImage(url: book.bookImageURL) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 70, height: 115)
                        
                    }
                }
                .navigationBarTitle(Text("Bestsellers"), displayMode: .large)
                .listStyle(.plain)
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
