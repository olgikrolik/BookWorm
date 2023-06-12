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
    
    func fetchBookDetails(bookTitle: String, bookAuthor: String) {
        let (titleWithPlusBetweenWords, authorWithPlusBetweenWords) = addPlusBetweenWords(title: bookTitle, author: bookAuthor)
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=intitle:\(titleWithPlusBetweenWords)+inauthor:\(authorWithPlusBetweenWords)&key=AIzaSyBO7kh2ZpihDXbvsuzT5A9HEunlE8wSrDw") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    
                }
                if let data = data {
                    DispatchQueue.main.async {
                        do {
                            self.bookInfo = try self.bookInfo(from: data)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func bookInfo(from data: Data) throws -> BookInfo {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(BookDetailsData.self, from: data)
        let volumeInfo = decodedData.items[0].volumeInfo // stworzyć osobną func createBookInfoFromBookDetailsData
        let buyLink = decodedData.items[0].saleInfo.buyLink
        let previewLink = volumeInfo.previewLink
        var isbn: String = isbn(from: volumeInfo)
        var pageCount: String = pageCount(from: volumeInfo)
        var formattedPublishedDate: String = formattedPublishedDate(from: volumeInfo)
        var description: String = description(from: volumeInfo)
        return BookInfo(isbn: isbn, pageCount: pageCount, formattedPublishedDate: formattedPublishedDate, description: description, buyLink: buyLink, previewLink: previewLink)
    }
 
    func addPlusBetweenWords(title: String, author: String) -> (titleWithPlusBetweenWords: String, authorWithPlusBetweenWords: String) {
        let titleWithPlusBetweenWords = title.replacingOccurrences(of: " ", with: "+")
        let authorWithPlusBetweenWords = author.replacingOccurrences(of: " ", with: "+")
        
        return (titleWithPlusBetweenWords, authorWithPlusBetweenWords)
    }
    
    func isbn(from volumeInfo: VolumeInfo) -> String {
        if volumeInfo.ISBNIdentifiers.isEmpty {
            return "unknown"
        } else {
            return volumeInfo.ISBNIdentifiers[0].ISBN ?? "unknown"
        }
    }
    
    func pageCount(from volumeInfo: VolumeInfo) -> String {
        if let unwrappedPageCount = volumeInfo.pageCount {
            if unwrappedPageCount == 0 {
                return "unknown"
            } else {
                return String(unwrappedPageCount)
            }
        } else {
            return "unknown"
        }
    }
    
    func formattedPublishedDate(from volumeInfo: VolumeInfo) -> String {
        if let unwrappedPublishedDate = volumeInfo.publishedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "y-MM-dd"
            if let date = dateFormatter.date(from: unwrappedPublishedDate) {
                dateFormatter.dateFormat = "dd.MM.Y"
                return dateFormatter.string(from: date)
            } else {
                return "unknown"
            }
        } else {
            return "unknown"
        }
    }
    
    func description(from volumeInfo: VolumeInfo) -> String {
        if let unwrappedDescription = volumeInfo.description {
            return unwrappedDescription
        } else {
            return "unknown"
        }
    }
}
