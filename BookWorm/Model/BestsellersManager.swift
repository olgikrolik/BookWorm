//
//  BestsellersManager.swift
//  BookWorm
//
//  Created by Olga Królikowska on 06/04/2023.
//

import Foundation

class BestsellersManager: ObservableObject {
    
    @Published var bookData = [Book]()
    @Published var listDateData = ""
    @Published var previousListDateData = ""
    @Published var nextListDateData = ""
    @Published var showError = false
    
    func fetchBestsellers(listGenre: String, bestsellersListDate: String) {
        if let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/\(bestsellersListDate)/\(listGenre).json?api-key=1NLFuQmHxAXMm4A7BtJo3t6hAtE5WqjG") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let response = response as? HTTPURLResponse, response.statusCode == 429 {
                    DispatchQueue.main.async {
                        self.showError = true
                    }
                } else {
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safedata = data {
                            do {
                                let decodedData = try decoder.decode(BestsellersData.self, from: safedata)
                                DispatchQueue.main.async {
                                    self.bookData = decodedData.results.books
                                    self.listDateData = decodedData.results.listPublishedDate
                                    self.previousListDateData = decodedData.results.previousPublishedDate
                                    self.nextListDateData = decodedData.results.nextPublishedDate
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
