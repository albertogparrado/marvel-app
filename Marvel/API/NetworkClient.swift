//
//  NetworkClient.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import Alamofire
import Foundation


class NetworkClient{
    
    //API Marvel info
    private let baseURL = "https://gateway.marvel.com"
    private let characterPath = "/v1/public/characters"
    
    private lazy var timestamp : Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    
    // HASH API Marvel
    // (e.g. md5(ts+privateKey+publicKey))
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)\(publicKey)")
    }()
    
    func getCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseURL)\(characterPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 100,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
}
enum NetworkError: Error, LocalizedError {
    case serverError(String)
    case dataError(String)
    case serializationError(String)
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let descrition):
            return descrition
        case .dataError(let descrition):
            return descrition
        case .serializationError(let descrition):
            return descrition
        }
    }
}


struct CharacterResponse: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: CharacterData?
    var etag: String?
}
struct CharacterData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterResult]?
}
struct CharacterResult: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [CharacterUrl]?
    var thumbnail: Thumbnail?
    var comics: Comics?
    var stories: Stories?
    var events: Events?
    var series: Series?
}
struct CharacterUrl: Codable {
    var type: String?
    var url: String?
}
struct Thumbnail: Codable {
    var path: String?
    var thumbExtension: String?
    private enum CodingKeys: String, CodingKey {
        case path
        case thumbExtension = "extension"
    }
}
struct Comics: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicItem]?
}
struct ComicItem: Codable {
    var resourceURI: String?
    var name: String?
}
struct Stories: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorieItem]?
}
struct StorieItem: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?
}
struct Events: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventItem]?
}
struct EventItem: Codable {
    var resourceURI: String?
    var name: String?
}
struct Series: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SerieItem]?
}
struct SerieItem: Codable {
    var resourceURI: String?
    var name: String?
}




/*
 {
 "code": "int",
 "status": "string",
 "copyright": "string",
 "attributionText": "string",
 "attributionHTML": "string",
 "data": {
 "offset": "int",
 "limit": "int",
 "total": "int",
 "count": "int",
 "results": [
 {
 "id": "int",
 "name": "string",
 "description": "string",
 "modified": "Date",
 "resourceURI": "string",
 "urls": [
 {
 "type": "string",
 "url": "string"
 }
 ],
 "thumbnail": {
 "path": "string",
 "extension": "string"
 },
 "comics": {
 "available": "int",
 "returned": "int",
 "collectionURI": "string",
 "items": [
 {
 "resourceURI": "string",
 "name": "string"
 }
 ]
 },
 "stories": {
 "available": "int",
 "returned": "int",
 "collectionURI": "string",
 "items": [
 {
 "resourceURI": "string",
 "name": "string",
 "type": "string"
 }
 ]
 },
 "events": {
 "available": "int",
 "returned": "int",
 "collectionURI": "string",
 "items": [
 {
 "resourceURI": "string",
 "name": "string"
 }
 ]
 },
 "series": {
 "available": "int",
 "returned": "int",
 "collectionURI": "string",
 "items": [
 {
 "resourceURI": "string",
 "name": "string"
 }
 ]
 }
 }
 ]
 },
 "etag": "string"
 }
 */
