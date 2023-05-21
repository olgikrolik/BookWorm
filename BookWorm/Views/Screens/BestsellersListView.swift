//
//  ContentView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 30/03/2023.
//

import SwiftUI

struct BestsellersListView: View {
    
    @ObservedObject var bestsellersManager = BestsellersManager()
    @State private var selectedBookGenre = 0
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Book genre", selection: $selectedBookGenre) {
                    Text("Fiction")
                        .tag(0)
                    Text("Nonfiction")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .colorMultiply(.accentColor)
                
                HStack {
                    Button {
                        if selectedBookGenre == 0 {
                            self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: bestsellersManager.previousListDate)
                        } else {
                            self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: bestsellersManager.previousListDate)
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.backward")
                    }
                    
                    Text(bestsellersManager.formattedListDate)
                        .padding()
                        .font(.custom("Montserrat-Light", size: 13))
                    
                    Button {
                        if selectedBookGenre == 0 {
                            self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: bestsellersManager.nextListDate)
                        } else {
                            self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: bestsellersManager.nextListDate)
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.forward")
                    }
                    
                }
                List(bestsellersManager.bookData) { book in
                    NavigationLink(value: book) {
                        HStack {
                            VStack {
                                Text(String(book.rank))
                                    .foregroundColor(.accentColor)
                                    .font(.custom("Montserrat-Light", size: 34))
                                    .frame(width: 35)
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
                }
                .navigationDestination(for: Book.self) { book in
//                    BookDetailsView(book: book)
                    BookDetailsView()
                }
                .navigationBarTitle(Text("Bestsellers"), displayMode: .large)
                .listStyle(.plain)
            }
        }
        .padding()
        .onAppear {
            self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: "current")
        }
        .onChange(of: selectedBookGenre) { value in
            if selectedBookGenre == 0 {
                self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: "")
            } else {
                self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: "")
            }
        }
        .alert(isPresented: $bestsellersManager.showError) {
            Alert(title: Text("Error"), message: Text("The maximum number of requests has been reached. Please wait 1 minute."), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BestsellersListView()
    }
}
