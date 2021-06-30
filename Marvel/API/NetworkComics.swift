//
//  NetworkComics.swift
//  Marvel
//
//  Created by Alberto on 25/6/21.
//


import Foundation
import Alamofire





class NetworkComics{
    
    //MARK:- VARIABLES
    private let baseURL = "https://gateway.marvel.com:443"
    private let characterPath = "/v1/public/characters/"
    //    private let IDcharacter = ""
    private let endURL = "/comics?apikey="
    private let comicPath = "/comics"
    private let idComic:Int = 0
    
    
    private lazy var timestamp : Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)\(publicKey)")
    }()
    
    
    
    
    
    
//    func getComics(characterID: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
//        AF.request(
//            "\(baseURL)\(characterPath)/\(idComic)\(comicPath)",
//            method: .get,
//            parameters: [
//                "apikey": publicKey,
//                "hash": hash,
//                "ts": timestamp,
//                "limit": 100,
//                //            "offset": offset
//            ]
//        ).validate(statusCode: 200 ..< 299).responseJSON{responseAPIComic in
//            guard responseAPIComic.error == nil else {
//                completion(.failure(.serverError("Ha ocurrido algun error: \(responseAPIComic.error?.localizedDescription ?? "")")))
//                return
//            }
//            guard let secureData = responseAPIComic.data else {
//                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
//                return
//            }
//            do {
//                print(responseAPIComic.data ?? <#default value#>)
//            } catch {
//                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
//                return
//            }
        }
        
//    }
//
//}












