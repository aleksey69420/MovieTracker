//
//  Movie.swift
//  MovieTracker
//
//  Created by Aleksey on 5/18/22.
//

import Foundation

struct Movie: Decodable {
	let id: Int
	let originalLanguage: String
	let originalTitle: String
	let overview: String
	let releaseDate: String
	let posterUrl: String?
	let popularity: Double
	let title: String
	let isVideoAvailable: Bool
	let voteAverage: Double
	let voteCount: Int
	let isAdultContent: Bool
	let backdropUrl: String?
	let genres: [Int]
	
	
	enum CodingKeys: String, CodingKey {
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case posterUrl = "poster_path"
		case isVideoAvailable = "video"
		case voteAverage = "vote_average"
		case overview
		case id
		case voteCount = "vote_count"
		case isAdultContent = "adult"
		case backdropUrl = "backdrop_path"
		case title = "title"
		case genres = "genre_ids"
		case releaseDate  = "release_date"
		case popularity = "popularity"
	}
}


struct MovieResults: Decodable {
	let page: Int
	let results: [Movie]
	let totalPages: Int
	let totalResults: Int
	
	
	enum CodingKeys: String, CodingKey {
		case page
		case results
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}
