//
//  Movie.swift
//  MovieDB
//
//  Created by Jake Haslam on 3/13/20.
//  Copyright © 2020 Jake Haslam. All rights reserved.
//

import UIKit

struct TopLevelobject: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let rating: Double
    let overview: String
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case overview = "overview"
        case poster = "poster_path" 
    }
}

