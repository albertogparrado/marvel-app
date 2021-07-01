//
//  EventsAPI.swift
//  Marvel
//
//  Created by Alberto on 1/7/21.
//

import Foundation

struct EventResponse: Codable {
  //let code: Int?
  //let status, copyright, attributionText, attributionHTML: String?
  let data: EventData?
  //let etag: String?
}
struct EventData: Codable {
  //let offset, limit, total, count: Int?
  let results: [EventResult]?
}
struct EventResult: Codable {
  //let id, startYear, endYear: Int?
  //let title, description, resourceURL, rating: String?
  let urls: [EventUrl]?
  let thumbnail: EventThumbnail?
  /*let comics: SerieComic?
  let stories: SerieStory?
  let events: SerieEvent?
  let characters: SerieCharacter?
  let creators: SerieCreator?
  let next: SerieNext?
  let previous: SeriePreviou?*/
}
struct EventUrl: Codable {
  let type, url: String?
}
struct EventThumbnail: Codable {
  let path, extensionn: String?
  private enum CodingKeys: String, CodingKey{
    case path
    case extensionn = "extension"
  }
}
