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
                pickerBookGenreSelection
                HStack {
                    arrowBackwardButton
                    bestsellersListDate
                    arrowForwardButton
                }
                List(bestsellersManager.bookData) { book in
                    NavigationLink(value: book) {
                        HStack {
                            VStack {
                                bookRank(book: book)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                bookName(book: book)
                                bookWriter(book: book)
                                bookSummary(book: book)
                                Spacer()
                            }
                            Spacer()
                            bookCover(book: book)
                        }
                    }
                }
                .navigationDestination(for: Book.self) { book in
                    BookDetailsView(title: book.title, author: book.author, bookImageURL: book.bookImageURL)
                }
                .navigationBarTitle(Text("Bestsellers"), displayMode: .large)
                .listStyle(.plain)
            }
            .padding()
        }
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
    
    var pickerBookGenreSelection: some View {
        Picker("Book genre", selection: $selectedBookGenre) {
            Text("Fiction")
                .tag(0)
            Text("Nonfiction")
                .tag(1)
        }
        .pickerStyle(.segmented)
        .colorMultiply(.accentColor)
    }
    
    var arrowBackwardButton: some View {
        Button {
            if selectedBookGenre == 0 {
                self.bestsellersManager.fetchBestsellers(listGenre: "trade-fiction-paperback", bestsellersListDate: bestsellersManager.previousListDate)
            } else {
                self.bestsellersManager.fetchBestsellers(listGenre: "paperback-nonfiction", bestsellersListDate: bestsellersManager.previousListDate)
            }
        } label: {
            Image(systemName: "arrowtriangle.backward")
        }
    }
    
    var bestsellersListDate: some View {
        Text(bestsellersManager.formattedListDate)
            .padding()
            .font(.custom("Montserrat-Light", size: 13))
    }
    
    var arrowForwardButton: some View {
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
    
    func bookRank(book: Book) -> some View {
        Text(String(book.rank))
            .foregroundColor(.accentColor)
            .font(.custom("Montserrat-Light", size: 34))
            .frame(width: 35)
    }
    
    func bookName(book: Book) -> some View {
        Text(String(book.title))
            .font(.custom("Montserrat-Regular", size: 17))
            .padding(.top, 5)
    }
    
    func bookWriter(book: Book) -> some View {
        Text("by \(book.author)")
            .font(.custom("Montserrat-Light", size: 15))
    }
    
    func bookSummary(book: Book) -> some View {
        Text(String(book.description))
            .font(.custom("Montserrat-Regular", size: 13))
            .padding(.top, 3)
    }
    
    func bookCover(book: Book) -> some View {
        AsyncImage(url: book.bookImageURL) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 70, height: 115)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BestsellersListView()
    }
}
