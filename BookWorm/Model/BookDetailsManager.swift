//
//  BookDetailsManager.swift
//  BookWorm
//
//  Created by Olga Królikowska on 18/05/2023.
//

import Foundation

struct BookInfo {
    let isbn: String
    let pageCount: String
    let formattedPublishedDate: String
    let description: String
    let buyLink: URL?
    let previewLink: URL?
}

class BookDetailsManager: ObservableObject {
    
    @Published var bookInfo: BookInfo = BookInfo(isbn: "", pageCount: "", formattedPublishedDate: "", description: "", buyLink: nil, previewLink: nil)
    
    init() {
        print("")
    }
    
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
                                let bookInfoApiData = decodedData.items[0].volumeInfo // stworzyć osobną func createBookInfoFromBookDetailsData
                                let buyLink = decodedData.items[0].saleInfo.buyLink
                                let previewLink = bookInfoApiData.previewLink
                                
                                var isbn: String
                                if bookInfoApiData.ISBNIdentifiers.isEmpty {
                                    isbn = "unknown"
                                } else {
                                    isbn = bookInfoApiData.ISBNIdentifiers[0].ISBN ?? "unknown"
                                }
                                
                                var pageCount: String
                                if let unwrappedPageCount = bookInfoApiData.pageCount {
                                    if unwrappedPageCount == 0 {
                                        pageCount = "unknown"
                                    } else {
                                        pageCount = String(unwrappedPageCount)
                                    }
                                } else {
                                    pageCount = "unknown"
                                }
                                
                                var formattedPublishedDate: String
                                if let unwrappedPublishedDate = bookInfoApiData.publishedDate {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "y-MM-dd"
                                    if let date = dateFormatter.date(from: unwrappedPublishedDate) {
                                        dateFormatter.dateFormat = "dd.MM.Y"
                                        formattedPublishedDate = dateFormatter.string(from: date)
                                    } else {
                                        formattedPublishedDate = "unknown"
                                    }
                                } else {
                                    formattedPublishedDate = "unknown"
                                }
                                
                                var description: String
                                if let unwrappedDescription = bookInfoApiData.description {
                                    description = unwrappedDescription
                                } else {
                                    description = "unknown"
                                }
                                
                                self.bookInfo = BookInfo(isbn: isbn, pageCount: pageCount, formattedPublishedDate: formattedPublishedDate, description: description, buyLink: buyLink, previewLink: previewLink)
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
