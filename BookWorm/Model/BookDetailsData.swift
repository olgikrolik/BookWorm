//
//  BookDetailsData.swift
//  BookWorm
//
//  Created by Olga Królikowska on 19/05/2023.
//

import Foundation

struct BookDetailsData: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let previewLink: URL?
    let buyLink: URL?
    let ISBNIdentifiers: [ISBNIdentifiers]
    
    enum CodingKeys: String, CodingKey {
        case publishedDate = "publishedDate"
        case description = "description"
        case pageCount = "pageCount"
        case previewLink = "previewLink"
        case buyLink = "buyLink"
        case ISBNIdentifiers = "industryIdentifiers"
        
    }
}

struct ISBNIdentifiers : Decodable {
    let ISBN: String?
    
    enum CodingKeys: String, CodingKey {
        case ISBN = "identifier"
    }
}


