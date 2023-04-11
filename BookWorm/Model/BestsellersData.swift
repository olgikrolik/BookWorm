//
//  BestsellersData.swift
//  BookWorm
//
//  Created by Olga Królikowska on 07/04/2023.
//

import Foundation

struct BestsellersData: Decodable {
    let results: Results
}

struct Results: Decodable {
    let list_name_encoded: String
    let published_date: String
    let books: [Book]
}


struct Book: Decodable, Identifiable {
    let id = UUID()
    let rank: Int
    let title: String
    let author: String
    let description: String
    let bookImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case rank = "rank"
        case title = "title"
        case author = "author"
        case description = "description"
        case bookImageURL = "book_image"
    }
}

