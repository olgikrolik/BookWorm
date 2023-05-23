//
//  BookDetailsManager.swift
//  BookWorm
//
//  Created by Olga Królikowska on 18/05/2023.
//

import Foundation

class BookDetailsManager: ObservableObject {
    
    func fetchBookDetails(bookTitle: String, bookAuthor: String) {
        let (titleWithPlusBetweenWords, authorWithPlusBetweenWords) = addPlusBetweenWords(title: bookTitle, author: bookAuthor)
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=intitle:\(titleWithPlusBetweenWords)+inauthor:\(authorWithPlusBetweenWords)&key=AIzaSyBO7kh2ZpihDXbvsuzT5A9HEunlE8wSrDw") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safedata = data {
                        do {
                            let decodedData = try decoder.decode(BookDetailsData.self, from: safedata)
                            print(decodedData.items[0].volumeInfo.description)
                            print(decodedData.items[0].volumeInfo.industryIdentifiers[0].identifier)
                            print(decodedData.items[0].volumeInfo.industryIdentifiers[1].identifier)
                            print(decodedData.items[0].volumeInfo.pageCount)
                            print(decodedData.items[0].volumeInfo.previewLink)
                            print(decodedData.items[0].volumeInfo.buyLink)
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    func addPlusBetweenWords(title: String, author: String) -> (titleWithPlusBetweenWords: String, authorWithPlusBetweenWords: String) {
        let titleWithPlusBetweenWords = title.replacingOccurrences(of: " ", with: "+")
        let authorWithPlusBetweenWords = author.replacingOccurrences(of: " ", with: "+")
        
        return (titleWithPlusBetweenWords, authorWithPlusBetweenWords)
    }
    
}
