//
//  NetworkModel.swift
//  Flickr_iOS_challenge
//
//  Created by Yashwant Rao on 19/02/24.
//

import Foundation

@MainActor
class NetworkModel:  ObservableObject {
    
    @Published var items : [Item] = []
    
    func fetchImages(search: String) async throws {
        let  request  =  URLRequest(url: URL(string:"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(search)")!)
        let(data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(FlickerResponse.self, from: data)
        items  = response.items
        print(response)
    }
}
