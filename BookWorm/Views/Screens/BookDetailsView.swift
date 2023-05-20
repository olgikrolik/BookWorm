//
//  BookDetailsView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 03/05/2023.
//

import SwiftUI

struct BookDetailsView: View {
    
    @ObservedObject var bookDetailsManager = BookDetailsManager()
    @State private var text: String = ""
    
    var body: some View {
        
        ZStack {
            AsyncImage(url: URL(string: "https://storage.googleapis.com/du-prd/books/images/9781668001226.jpg")) { image in
                image
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 100)
                    .opacity(0.5)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.white)
            }
            ScrollView{
                VStack {
                    AsyncImage(url: URL(string: "https://storage.googleapis.com/du-prd/books/images/9781668001226.jpg")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 230)
                            .padding(.top, 50)
                    } placeholder: {
                        ProgressView()
                    }
                    Text("IT STARTS WITH US")
                        .foregroundColor(.accentColor)
                        .font(.custom("Montserrat-Regular", size: 20))
                        .padding(.top, 20)
                    VStack (alignment: .leading) {
                        Text(mergeDefinitionAndDescription(definition: "Author: ", description: "Coleen Hoover"))
                        Text(mergeDefinitionAndDescription(definition: "ISBN: ", description: "9781668001233, 1668001233"))
                        Text(mergeDefinitionAndDescription(definition: "Page count: ", description: "336"))
                        Text(mergeDefinitionAndDescription(definition: "Published date: ", description: "18 October 2022"))
                    }
                    .frame(maxWidth: 300)
                    .padding(.top, 5)
                    
                    HStack {
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
                    .padding(.top, 20)
                    
                            Text("Before It Ends with Us, it started with Atlas. Colleen Hoover tells fan favorite Atlas’s side of the story and shares what comes next in this long-anticipated sequel to the “glorious and touching” (USA TODAY) #1 New York Times bestseller It Ends with Us. Lily and her ex-husband, Ryle, have just settled into a civil coparenting rhythm when she suddenly bumps into her first love, Atlas, again. After nearly two years separated, she is elated that for once, time is on their side, and she immediately says yes when Atlas asks her on a date. But her excitement is quickly hampered by the knowledge that, though they")
                                .multilineTextAlignment(.leading)
                                .font(.custom("Montserrat-ExtraLight", size: 14))
                                .padding(.top, 20)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                    }
                }
            }
        .onAppear {
            self.bookDetailsManager.fetchBookDetails(bookTitle: "It+starts+with+us", bookAuthor: "Colleen+Hoover")
        }
        }
    }
    func mergeDefinitionAndDescription(definition: String, description: String) -> AttributedString {
        var definitionAttributedString = AttributedString(definition)
        definitionAttributedString.font = .custom("Montserrat-Regular", size: 14)
        
        var descriptionAttributedString = AttributedString(description)
        descriptionAttributedString.font = .custom("Montserrat-ExtraLight", size: 14)
        
        return definitionAttributedString + descriptionAttributedString
    }
    


struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView()

    }
}
