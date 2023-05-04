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
                } placeholder: {
                    ProgressView()
                }
                Text("IT STARTS WITH US")
                    .foregroundColor(.accentColor)
                    .font(.custom("Montserrat-Regular", size: 20))
                VStack {
                        
                }
                
            }
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView()

    }
}
