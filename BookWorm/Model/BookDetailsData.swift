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
    let publishedDate: String
    let description: String
    let pageCount: Int
    let previewLink: URL?
    let buyLink: URL?
    let industryIdentifiers: [IndustryIdentifiers]
}

struct IndustryIdentifiers : Decodable {
    let identifier: String
}
