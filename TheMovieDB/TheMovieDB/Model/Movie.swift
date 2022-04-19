//
//  Movie.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

struct Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case id
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
    }
    
    let title: String
    let rating: Double
    let id: Int
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let releaseDate: String
    
}

struct MovieDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
    
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
}
