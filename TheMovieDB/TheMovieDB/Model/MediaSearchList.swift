//
//  MediaSearchList.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

struct MediaSearchList: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
    
    let page: Int
    var results: [Movie]
}
