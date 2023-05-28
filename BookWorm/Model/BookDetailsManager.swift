//
//  BookDetailsManager.swift
//  BookWorm
//
//  Created by Olga Królikowska on 18/05/2023.
//

import Foundation

class BookDetailsManager: ObservableObject {
    
    @Published var bookInfo: VolumeInfo?
    
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
                            DispatchQueue.main.async {
                                self.bookInfo = decodedData.items[0].volumeInfo
                            }
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
