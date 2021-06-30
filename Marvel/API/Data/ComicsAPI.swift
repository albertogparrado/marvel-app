//
//  Comics.swift
//  Marvel
//
//  Created by Alberto on 29/6/21.
//

import Foundation

/*
 struct ComicResponse: Codable{
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [ComicsResult]
}



// MARK: - Result
struct ComicsResult: Codable {
    let id, digitalID: Int
    let title: String
    let issueNumber: Int
    let variantDescription: VariantDescription
    let resultDescription: String?
    let modified, isbn, upc, diamondCode: String
    let ean, issn: String
    let format: Format
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants: [Series]
    let collections, collectedIssues: [Any]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let stories: Stories

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct CharactersComic: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicSeries]
    let returned: Int
}

// MARK: - Series
struct ComicSeries: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: Role
}

enum Role: String, Codable {
    case colorist = "colorist"
    case editor = "editor"
    case inker = "inker"
    case letterer = "letterer"
    case penciler = "penciler"
    case penciller = "penciller"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType
    let date: String
}

enum DateType: String, Codable {
    case digitalPurchaseDate = "digitalPurchaseDate"
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
    case unlimitedDate = "unlimitedDate"
}

enum Format: String, Codable {
    case comic = "Comic"
}

// MARK: - Thumbnail
struct ComicThumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
}

enum PriceType: String, Codable {
    case digitalPurchasePrice = "digitalPurchasePrice"
    case printPrice = "printPrice"
}

// MARK: - Stories
struct ComicStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - TextObject
struct TextObject: Codable {
    let type: TextObjectType
    let language: Language
    let text: String
}

enum Language: String, Codable {
    case enUs = "en-us"
}

enum TextObjectType: String, Codable {
    case issuePreviewText = "issue_preview_text"
    case issueSolicitText = "issue_solicit_text"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case detail = "detail"
    case inAppLink = "inAppLink"
    case purchase = "purchase"
    case reader = "reader"
}

enum VariantDescription: String, Codable {
    case empty = ""
    case spotlightVariant = "SPOTLIGHT VARIANT"
    case zombieVariant = "ZOMBIE VARIANT"
}


*/
