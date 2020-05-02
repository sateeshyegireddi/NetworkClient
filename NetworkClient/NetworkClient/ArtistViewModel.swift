//
//  UserViewModel.swift
//  Networking
//
//  Created by Sateesh Yemireddi on 4/5/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

struct ArtistViewModel {
    
    func searchArtist() {
        let url = ArtistURL(base: BaseURL.base.rawValue,
                            path: URLPath.search.rawValue,
                            query: ArtistQueries(term: "ARRehman", country: "IN"))
        let request = ArtistURLRequest(with: url)
        APIClient(with: request).fetch(Response<[Artist]>.self) { result in
            switch result {
            case .success(let artists):
                print(artists.result)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct ArtistURL: URLComponent {
    var base: String
    var path: String
    var query: Encodable?
}

struct ArtistQueries: Encodable {
    var term: String
    var country: String
}

struct ArtistURLRequest: URLRequestable {
    var urlComponent: URLComponent
    init(with url: URLComponent) {
        self.urlComponent = url
    }
}
