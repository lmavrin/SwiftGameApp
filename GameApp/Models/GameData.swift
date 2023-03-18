//
//  Games.swift
//  GameApp
//
//  Created by Luka Mavrin on 01.12.2022..
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gameSearchData = try? newJSONDecoder().decode(GameSearchData.self, from: jsonData)

import Foundation

// MARK: - GameSearchData
struct GameData: Codable {
	let count: Int?
	let next: String?
	let previous: String?
	let results: [Result]?
	let seoTitle, seoDescription, seoKeywords, seoH1: String?
	let noindex, nofollow: Bool?
	let gameSearchDataDescription: String?
	let filters: Filters?
	let nofollowCollections: [String]?

	enum CodingKeys: String, CodingKey {
		case count, next, previous, results
		case seoTitle = "seo_title"
		case seoDescription = "seo_description"
		case seoKeywords = "seo_keywords"
		case seoH1 = "seo_h1"
		case noindex, nofollow
		case gameSearchDataDescription = "description"
		case filters
		case nofollowCollections = "nofollow_collections"
	}
}

// MARK: - Filters
struct Filters: Codable {
	let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
	let from, to: Int?
	let filter: String?
	let decade: Int?
	let years: [YearYear]?
	let nofollow: Bool?
	let count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
	let year, count: Int?
	let nofollow: Bool?
}

// MARK: - Result
struct Result: Codable,Identifiable {
	let id: Int?
	let slug, name: String?
	let released: String?
	let tba: Bool?
	let backgroundImage: String?
	let rating: Double?
	let ratingTop: Int?
	let ratings: [Rating]
	let ratingsCount, reviewsTextCount, added: Int?
	let addedByStatus: AddedByStatus?
	let metacritic: Int?
	let playtime, suggestionsCount: Int?
	let updated: String?
	let userGame: JSONNull?
	let platform: Platform?
	let reviewsCount: Int?
	let saturatedColor, dominantColor: Colorz?
	let platforms: [PlatformElement]?
	let parentPlatforms: [ParentPlatform]?
	let genres: [Genre]?
	let stores: [Store]?
	let clip: JSONNull?
	let tags: [Genre]?
	let esrbRating: EsrbRating?
	let shortScreenshots: [ShortScreenshot]?

	enum CodingKeys: String, CodingKey {
		case id, slug, name, released, tba
		case backgroundImage = "background_image"
		case rating
		case ratingTop = "rating_top"
		case ratings
		case ratingsCount = "ratings_count"
		case reviewsTextCount = "reviews_text_count"
		case added

		case platform
		case addedByStatus = "added_by_status"
		case metacritic, playtime
		case suggestionsCount = "suggestions_count"
		case updated
		case userGame = "user_game"
		case reviewsCount = "reviews_count"
		case saturatedColor = "saturated_color"
		case dominantColor = "dominant_color"
		case platforms
		case parentPlatforms = "parent_platforms"
		case genres, stores, clip, tags
		case esrbRating = "esrb_rating"
		case shortScreenshots = "short_screenshots"
	}
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
	let owned: Int?
	let yet, beaten, toplay: Int?
	let dropped, playing: Int?
}


enum Colorz: String, Codable {
	case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
	let id: Int
	let name: String?
	let slug: String?
}
// MARK: - Platform
struct Platform: Codable {
	let platform: Genre?
}




// MARK: - Genre
struct Genre: Codable {
	let id: Int
	let name, slug: String?
	let gamesCount: Int?
	let imageBackground: String?
	let domain: String?
	let language: String?

	enum CodingKeys: String, CodingKey {
		case id, name, slug
		case gamesCount = "games_count"
		case imageBackground = "image_background"
		case domain, language
	}
}


// MARK: - ParentPlatform
struct ParentPlatform: Codable {
	let platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
	let platform: PlatformPlatform?
	let releasedAt: String?
	let requirementsEn, requirementsRu: Requirements?

	enum CodingKeys: String, CodingKey {
		case platform
		case releasedAt = "released_at"
		case requirementsEn = "requirements_en"
		case requirementsRu = "requirements_ru"
	}
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
	let id: Int
	let name, slug: String?
	let image, yearEnd: JSONNull?
	let yearStart: Int?
	let gamesCount: Int?
	let imageBackground: String?

	enum CodingKeys: String, CodingKey {
		case id, name, slug, image
		case yearEnd = "year_end"
		case yearStart = "year_start"
		case gamesCount = "games_count"
		case imageBackground = "image_background"
	}
}

// MARK: - Requirements
struct Requirements: Codable {
	let minimum: String?
	let recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
	let id: Int
	let title: String?
	let count: Int
	let percent: Double
}



// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
	let id: Int
	let image: String
}

// MARK: - Store
struct Store: Codable {
	let id: Int?
	let store: Genre?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}

	public var hashValue: Int {
		return 0
	}

	public func hash(into hasher: inout Hasher) {
		// No-op
	}

	public init() {}

	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
