//
//  BestsellersManager.swift
//  BookWorm
//
//  Created by Olga Królikowska on 06/04/2023.
//

import Foundation

class BestsellersManager: ObservableObject {
    
    @Published var booksData = [Book]()
    
    func fetchData() {
        if let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/trade-fiction-paperback.json?api-key=1NLFuQmHxAXMm4A7BtJo3t6hAtE5WqjG") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safedata = data {
                        do {
                            let decodedData = try decoder.decode(BestsellersData.self, from: safedata)
                            DispatchQueue.main.async {
                                self.booksData = decodedData.results.books
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
}
