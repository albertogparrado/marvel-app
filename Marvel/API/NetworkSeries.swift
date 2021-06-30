//
//  NetworkSeries.swift
//  Marvel
//
//  Created by Alberto on 29/6/21.
//

import Foundation
import Alamofire



//https://gateway.marvel.com/v1/public/characters/1017100/series

class NetworkSeries{
    
    //MARK:- VARIABLES
    private let baseURL = "https://gateway.marvel.com"
    private let seriesPath = "/v1/public/characters/"
    private let seriesEndPath = "/series"
    
    
    
    private lazy var timestamp : Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)")
    }()
    
    
    func getSeries(characterID: Int, completion: @escaping (Result<SerieResponse, NetworkError>) -> Void) {
        print("\(baseURL)\(seriesPath)\(characterID)\(seriesEndPath)")
       print([
        "apikey": publicKey,
        "hash": hash,
        "ts": timestamp,
        //    "limit": 100,
        //            "offset": offset
    ])
        
        AF.request(
            
            "\(baseURL)\(seriesPath)\(characterID)\(seriesEndPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp
                //    "limit": 100,
                //            "offset": offset
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
                print(secureData)
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
        
    }
    
}












