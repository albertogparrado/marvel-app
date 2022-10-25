//
//  DetailHeroeViewModel.swift
//  Marvel
//
//  Created by Alberto on 25/10/22.
//

import Foundation

class DetailHeroeViewModel {
    
    // MARK: VARIABLES
    var heroeInfo: CharacterResult?
    var seriesAPI: [SerieResult] = []
    var comicsAPI: [ComicResult] = []
    var eventsAPI: [EventResult] = []
    private var offset: Int = 0
    var misCellsComics: MCell = MCell(xibName: "ComicsCVC", idReuse: "ComicCell")
    var misCellsSeries: MCell = MCell(xibName: "SeriesCollectionViewCell", idReuse: "SerieCell")
    var misCellsEvents: MCell = MCell(xibName: "EventsCVC", idReuse: "EventCell")
    
    // MARK: FUNCTIONS
    func createUrlImageHeroe() -> URL? {
        guard let infoHeroe = heroeInfo else { return nil }
        if let thumbnail = infoHeroe.thumbnail?.path, let heroeExtension = infoHeroe.thumbnail?.thumbExtension {
            let urlHTTP = thumbnail + "." + heroeExtension
            let URLimageHHTPS = "https" + urlHTTP.dropFirst(4)
            return URL(string: URLimageHHTPS)
        } else { return nil }
    }
    
    func loadDataComics(completion: @escaping (Bool) -> Void) {
        guard let heroIDSecure = heroeInfo?.id else { return }
        NetworkClient().getComics(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let comics):
                guard let secureResults = comics.data?.results else { return }
                self.comicsAPI = secureResults
                completion(true)
            case .failure:
                print("error al cargar datos desde la API")
                completion(false)
            }
        }
    }
    
    func loadDataSeries(completion: @escaping (Bool) -> Void) {
        guard let heroIDSecure = heroeInfo?.id else { return }
        NetworkClient().getSeries(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let series):
                guard let secureResults = series.data?.results else { return }
                self.seriesAPI = secureResults
                completion(true)
            case .failure:
                print("error al cargar datos desde la API")
                completion(false)
            }
        }
    }
    
    func loadDataEvents(completion: @escaping (Bool) -> Void) {
        guard let heroIDSecure = heroeInfo?.id else { return }
        NetworkClient().getEvents(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let series):
                guard let secureResults = series.data?.results else { return }
                self.eventsAPI = secureResults
                completion(true)
            case .failure:
                print("error al cargar datos desde la API")
                completion(false)
            }
        }
    }
}

