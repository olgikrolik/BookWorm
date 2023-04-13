//
//  ContentView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bestsellersManager = BestsellersManager()
    @State private var bookGenre = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Book genre", selection: $bookGenre) {
                    Text("Fiction")
                        .tag(0)
                    Text("Nonfiction")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .colorMultiply(.accentColor)
                
                HStack {
                    Button {
                        if bookGenre == 0 {
                            self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: bestsellersManager.previousListDateData)
                        } else {
                            self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: bestsellersManager.previousListDateData)
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.backward")
                    }
                    
                    Text(bestsellersManager.listDateData)
                        .padding()
                        .font(.custom("Montserrat-Light", size: 13))
                    
                    Button {
                        print("right button was tapped")
                    } label: {
                        Image(systemName: "arrowtriangle.forward")
                    }
                    
                }
                List(bestsellersManager.bookData) { book in
                    HStack {
                        VStack {
                            Text(String(book.rank))
                                .foregroundColor(.accentColor)
                                .font(.custom("Montserrat-Light", size: 36))
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(String(book.title))
                                .font(.custom("Montserrat-Regular", size: 17))
                                .padding(.top, 5)
                            Text("by \(book.author)")
                                .font(.custom("Montserrat-Light", size: 15))
                            Text(String(book.description))
                                .font(.custom("Montserrat-Regular", size: 13))
                                .padding(.top, 3)
                            Spacer()
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
            self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: "current")
        }
        .onChange(of: bookGenre) { value in
            if bookGenre == 0 {
                self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: "")
            } else {
                self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
