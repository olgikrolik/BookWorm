//
//  BookDetailsView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 03/05/2023.
//

import SwiftUI

struct BookDetailsView: View {
    
    @StateObject var bookDetailsManager = BookDetailsManager()
    @State private var showingBuyWebSheet = false
    @State private var showingPreviewWebSheet = false
    
    let title: String
    let author: String
    let bookImageURL: URL
    
    var body: some View {
        ZStack {
            blurredBackgroundImage
            ScrollView{
                VStack {
                    bookImage
                    bookTitle
                    VStack (alignment: .leading) {
                        bookAuthor
                        bookISBN
                        bookPageCount
                        bookPublishedDate
                    }
                    .frame(maxWidth: 300)
                    .padding(.top, 5)
                    
                    HStack {
                        if let urlBuyLink = bookDetailsManager.bookInfo.buyLink {
                            buyLinkButton(url: urlBuyLink)
                        }
                        if let urlPreviewLink = bookDetailsManager.bookInfo.previewLink {
                            previewLinkButton(url: urlPreviewLink)
                        }
                    }
                    .padding(.top, 20)
                    bookDescription
                }
            }
        }
        .onAppear {
            self.bookDetailsManager.fetchBookDetails(bookTitle: title, bookAuthor: author)
        }
        .alert(isPresented: $bookDetailsManager.showErrorMessage) {
            Alert(title: Text("Error"), message: Text("Oops! Something went wrong."), dismissButton: .default(Text("OK")))
        }
    }
    
    func mergeDefinitionAndDescription(definition: String, description: String) -> AttributedString {
        var definitionAttributedString = AttributedString(definition)
        definitionAttributedString.font = .custom("Montserrat-Regular", size: 14)
        
        var descriptionAttributedString = AttributedString(description)
        descriptionAttributedString.font = .custom("Montserrat-ExtraLight", size: 14)
        
        return definitionAttributedString + descriptionAttributedString
    }
    
    var blurredBackgroundImage: some View {
        AsyncImage(url: bookImageURL) { image in
            image
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 100)
                .opacity(0.5)
        } placeholder: {
            Rectangle()
                .foregroundColor(.white)
        }
    }
    
    var bookImage: some View {
        AsyncImage(url: bookImageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 230)
        } placeholder: {
            ProgressView()
        }
    }
    
    var bookTitle: some View {
        Text(title)
            .foregroundColor(.black)
            .font(.custom("Montserrat-Regular", size: 20))
            .multilineTextAlignment(.center)
            .padding(.top, 20)
    }
    
    var bookAuthor: some View {
        Text(mergeDefinitionAndDescription(definition: "Author: ", description: author))
    }
    
    var bookISBN: some View {
        Text(mergeDefinitionAndDescription(definition: "ISBN: ", description: bookDetailsManager.bookInfo.isbn))
    }
    
    var bookPageCount: some View {
        Text(mergeDefinitionAndDescription(definition: "Page count: ", description: bookDetailsManager.bookInfo.pageCount))
    }
    
    var bookPublishedDate: some View {
        Text(mergeDefinitionAndDescription(definition: "Published date: ", description: bookDetailsManager.bookInfo.formattedPublishedDate))
    }
    
    func buyLinkButton(url: URL) -> some View {
        Button {
            showingBuyWebSheet.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.accentColor)
                .frame(width: 135, height: 50)
                .overlay(
                    Text("Buy")
                        .foregroundColor(.black)
                        .font(.custom("Montserrat-Regular", size: 18))
                )
        }
        .sheet(isPresented: $showingBuyWebSheet, content: {
            WebView(url: url)
        })
    }
    
    func previewLinkButton(url: URL) -> some View {
        Button {
            showingPreviewWebSheet.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.accentColor)
                .frame(width: 135, height: 50)
                .overlay(
                    Text("Preview")
                        .foregroundColor(.black)
                        .font(.custom("Montserrat-Regular", size: 18))
                )
        }
        .sheet(isPresented: $showingPreviewWebSheet) {
            WebView(url: url)
        }
    }
    
    var bookDescription: some View {
        Text(bookDetailsManager.bookInfo.description)
            .multilineTextAlignment(.leading)
            .font(.custom("Montserrat-ExtraLight", size: 14))
            .padding(.top, 20)
            .padding(.leading, 30)
            .padding(.trailing, 30)
    }
}


struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(title: "IT STARTS WITH US", author: "Coleen Hoover", bookImageURL: URL(string: "https://www.google.com/search?q=book&rlz=1C5CHFA_enPL1022PL1022&sxsrf=APwXEddCNZqSRlwH57c4i6N-9Gneb2glag:1684736157260&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjXiMaho4j_AhUOlosKHTbHDYYQ_AUoAXoECAEQAw&biw=1440&bih=821&dpr=2#imgrc=ubeJCyYL7jj5jM")!)
    }
}
