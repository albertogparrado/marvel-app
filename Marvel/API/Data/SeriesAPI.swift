//
//  SeriesAPI.swift
//  Marvel
//
//  Created by Alberto on 29/6/21.
//

import Foundation

struct SerieResponse: Codable {
  //let code: Int?
  //let status, copyright, attributionText, attributionHTML: String?
  let data: SerieData?
  //let etag: String?
}
struct SerieData: Codable {
  //let offset, limit, total, count: Int?
  let results: [SerieResult]?
}
struct SerieResult: Codable {
  //let id, startYear, endYear: Int?
  //let title, description, resourceURL, rating: String?
  let urls: [SerieUrl]?
  let thumbnail: SerieThumbnail?
  /*let comics: SerieComic?
  let stories: SerieStory?
  let events: SerieEvent?
  let characters: SerieCharacter?
  let creators: SerieCreator?
  let next: SerieNext?
  let previous: SeriePreviou?*/
}
struct SerieUrl: Codable {
  let type, url: String?
}
struct SerieThumbnail: Codable {
  let path, extensionn: String?
  private enum CodingKeys: String, CodingKey{
    case path
    case extensionn = "extension"
  }
}
