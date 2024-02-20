//
//  Flickr_iOS_challengeTests.swift
//  Flickr_iOS_challengeTests
//
//  Created by Yashwant Rao on 19/02/24.
//

import XCTest
@testable import Flickr_iOS_challenge

// Mock URLSessionProtocol for testing
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

final class Flickr_iOS_challengeTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Mock URLSession for testing
    class MockURLSession: URLSessionProtocol {
        func data(for request: URLRequest) async throws -> (Data, URLResponse) {
            // Provide mock data for testing
            let mockData = try XCTUnwrap("""
                  {
                      "items": [
                          // Add mock items as per your FlickerResponse structure
                      ]
                  }
                  """.data(using: .utf8))
            return (mockData, HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        }
    }
    
    
    private var netWorkModel: NetworkModel!
    
    @MainActor override func setUp() {
        //      netWorkModel = NetworkModel?
    }
    
    // Your test case for fetchImages
    func testFetchImages() async throws {
        // Arrange
        let sut = await NetworkModel()
        let searchQuery = "your_search_query"
        let expectedURLString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchQuery)"
        let expectedURL = try XCTUnwrap(URL(string: expectedURLString))
        let expectedRequest = URLRequest(url: expectedURL)
        
        
        try await sut.fetchImages(search: "porcupine")
        XCTAssertNotNil(sut)
    }
}
