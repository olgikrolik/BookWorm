//
//  BookDetailsView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 03/05/2023.
//

import SwiftUI

struct BookDetailsView: View {
    
    @ObservedObject var bookDetailsManager = BookDetailsManager()
    
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
                        buyLinkButton
                        previewLinkButton
                    }
                    .padding(.top, 20)
                    bookDescription
                }
            }
        }
        .onAppear {
            self.bookDetailsManager.fetchBookDetails(bookTitle: title, bookAuthor: author)
        }
    }
    
    
    func mergeDefinitionAndDescription(definition: String, description: String) -> AttributedString {
        var definitionAttributedString = AttributedString(definition)
        definitionAttributedString.font = .custom("Montserrat-Regular", size: 14)
        
        var descriptionAttributedString = AttributedString(description)
        descriptionAttributedString.font = .custom("Montserrat-ExtraLight", size: 14)
        
        return definitionAttributedString + descriptionAttributedString
    }
    
    @ViewBuilder
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
    
    @ViewBuilder
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
    
    @ViewBuilder
    var bookTitle: some View {
        Text(title)
            .foregroundColor(.accentColor)
            .font(.custom("Montserrat-Regular", size: 20))
            .padding(.top, 20)
    }
    
    @ViewBuilder
    var bookAuthor: some View {
        Text(mergeDefinitionAndDescription(definition: "Author: ", description: author))
    }
    
    @ViewBuilder
    var bookISBN: some View {
        Text(mergeDefinitionAndDescription(definition: "ISBN: ", description: "\(self.bookDetailsManager.bookInfo?.ISBNIdentifiers[0].ISBN ?? "lack of ISBN"), \(self.bookDetailsManager.bookInfo?.ISBNIdentifiers[1].ISBN ?? "lack of ISBN")"))
    }
    
    @ViewBuilder
    var bookPageCount: some View {
        Text(mergeDefinitionAndDescription(definition: "Page count: ", description: String(self.bookDetailsManager.bookInfo?.pageCount ?? 0)))
    }
    
    @ViewBuilder
    var bookPublishedDate: some View {
        Text(mergeDefinitionAndDescription(definition: "Published date: ", description: self.bookDetailsManager.bookInfo?.publishedDate ?? "-"))
    }
    
    @ViewBuilder
    var buyLinkButton: some View {
        Button {
            
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
    }
    
    @ViewBuilder
    var previewLinkButton: some View {
        Button {
            
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
    }
    
    @ViewBuilder
    var bookDescription: some View {
        Text(self.bookDetailsManager.bookInfo?.description ?? "lack of description")
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
