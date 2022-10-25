//
//  Comics.swift
//  Marvel
//
//  Created by Alberto on 29/6/21.
//

import Foundation


struct ComicResponse: Codable {
  // let code: Int?
  // let status, copyright, attributionText, attributionHTML: String?
  let data: ComicData?
  // let etag: String?
}
struct ComicData: Codable {
  // let offset, limit, total, count: Int?
  let results: [ComicResult]?
}
struct ComicResult: Codable {
  // let id, startYear, endYear: Int?
  // let title, description, resourceURL, rating: String?
  let urls: [ComicUrl]?
  let thumbnail: ComicThumbnail?
  /* let comics: SerieComic?
  let stories: SerieStory?
  let events: SerieEvent?
  let characters: SerieCharacter?
  let creators: SerieCreator?
  let next: SerieNext?
  let previous: SeriePreviou? */
}
struct ComicUrl: Codable {
  let type, url: String?
}
struct ComicThumbnail: Codable {
  let path, extensionn: String?
  private enum CodingKeys: String, CodingKey {
    case path
    case extensionn = "extension"
  }
}
