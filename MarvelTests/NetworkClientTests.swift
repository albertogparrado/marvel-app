//
//  NetworkClientTests.swift
//  MarvelTests
//
//  Created by Alberto on 25/10/22.
//

import XCTest
@testable import Marvel

final class NetworkClientTests: XCTestCase {
    
    var sut: NetworkClient?

    override func setUpWithError() throws {
        sut = NetworkClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getCharacters() {
        sut?.getCharacters(offset: -1, completion: { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure(let error):
                XCTAssert(false, "❌ Error getCharacters: \(error.localizedDescription)")
            }
        })
    }
    
    func test_getSeries() {
        sut?.getSeries(characterID: 0, offset: 0, completion: { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure(let error):
                XCTAssert(false, "❌ Error getSeries: \(error.localizedDescription)")
            }
        })
    }
    
    func test_getEvents() {
        sut?.getEvents(characterID: 0, offset: 0, completion: { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure(let error):
                XCTAssert(false, "❌ Error getEvents: \(error.localizedDescription)")
            }
        })
    }
}
