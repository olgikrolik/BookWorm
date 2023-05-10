//
//  BookDetailsView.swift
//  BookWorm
//
//  Created by Olga Królikowska on 03/05/2023.
//

import SwiftUI

struct BookDetailsView: View {
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
                            .frame(width: 135, height: 50)
                            .overlay(
                                Text("Buy")
                                    .foregroundColor(.black)
                            )
                    }
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 135, height: 50)
                            .overlay(
                                Text("Preview")
                                    .foregroundColor(.black)
                            )
                    }
                }
                .padding(.top, 20)
                
                Spacer()
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
    
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView()

    }
}
