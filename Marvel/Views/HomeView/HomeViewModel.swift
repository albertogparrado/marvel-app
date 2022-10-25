//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Alberto on 24/10/22.
//

import Foundation

class HomeViewModel {

    // MARK: VARIABLES
    var heroe: [CharacterResult] = []
    var misCell = MCell(xibName: "HeroeCell", idReuse: "ModelCell")
    var misCellLoading = MCell(xibName: "LoadCell", idReuse: "LoadingCell")
    var isLoading = false
    var offset: Int = 0
    var heroToSend: CharacterResult?

    // MARK: FUNCTIONS
    func networkSetup(completion: @escaping (Bool) -> Void) {
        if !isLoading {
            isLoading = true
            NetworkClient().getCharacters(offset: offset) { [self] result in
                switch result {
                case .success(let characters):
                    guard let secureResults = characters.data?.results else { return }
                    self.heroe.append(contentsOf: secureResults)
                    offset += heroe.count
                    completion(true)
                case .failure:
                    completion(false)
                }
                isLoading = false
            }
        }
    }
}
