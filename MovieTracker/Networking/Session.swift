//
//  Session.swift
//  MovieTracker
//
//  Created by Aleksey on 5/13/22.
//

import Foundation


struct TokenResponse: Codable {
	let success: Bool
	let expiresAt: String
	let requestToken: String
	
	enum CodingKeys: String, CodingKey {
		case success
		case expiresAt = "expires_at"
		case requestToken = "request_token"
	}
}


struct SessionRequest: Codable {
	let requestToken: String
	
	enum CodingKeys: String, CodingKey {
		case requestToken = "request_token"
	}
}


struct SessionResponse: Codable {
	let success: Bool
	let sessionId: String
	
	enum CodingKeys: String, CodingKey {
		case success
		case sessionId = "session_id"
	}
}
