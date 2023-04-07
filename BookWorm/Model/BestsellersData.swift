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
    let books: [Books]
}

struct Books: Decodable {
    let rank: Int
    let title: String
    let author: String
    let description: String
    let book_image: String
}

