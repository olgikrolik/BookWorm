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
    let listPublishedDate: String
    let previousPublishedDate: String
    let nextPublishedDate: String
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case listPublishedDate = "published_date"
        case previousPublishedDate = "previous_published_date"
        case nextPublishedDate = "next_published_date"
        case books = "books"
    }
}

struct Book: Decodable, Identifiable, Hashable {
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

