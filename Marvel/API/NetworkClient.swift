//
//  NetworkClient.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import Alamofire
import Foundation


class NetworkClient{
    
    //    MARK: VARIABLES
    private let baseURL = "https://gateway.marvel.com"
    private let characterPath = "/v1/public/characters"
    private let comicPath = "/comics"
    private let idComic:Int = 0
    private let seriesPath = "/v1/public/characters/"
    private let seriesEndPath = "/series"
    private let comicsEndPath = "/comics"
    private let eventsEndPath = "/events"
    
    private lazy var timestamp : Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)\(publicKey)")
    }()
    
    
    
    
    //    MARK: CHARACTERS
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
    
    //    MARK: SERIES
    func getSeries(characterID: Int, offset:Int, completion: @escaping (Result<SerieResponse, NetworkError>) -> Void) {
        AF.request(
            
            "\(baseURL)\(seriesPath)\(characterID)\(seriesEndPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 100,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON{responseAPISeries in
            guard responseAPISeries.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(responseAPISeries.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = responseAPISeries.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return 
            }
            do {
                let json = try JSONDecoder().decode(SerieResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    
    
    
    //    MARK: COMICS
    func getComics(characterID: Int, offset:Int, completion: @escaping (Result<ComicResponse, NetworkError>) -> Void) {
        
        AF.request(
            
            "\(baseURL)\(seriesPath)\(characterID)\(comicsEndPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 100,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON{responseAPISeries in
            guard responseAPISeries.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(responseAPISeries.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = responseAPISeries.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(ComicResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    
//    MARK: EVENTS
    func getEvents(characterID: Int, offset:Int, completion: @escaping (Result<EventResponse, NetworkError>) -> Void) {
        
        AF.request(
            
            "\(baseURL)\(seriesPath)\(characterID)\(eventsEndPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 100,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON{responseAPISeries in
            guard responseAPISeries.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(responseAPISeries.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = responseAPISeries.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(EventResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
}



//  MARK: ENUM
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


