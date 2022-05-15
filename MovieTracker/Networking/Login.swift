//
//  Login.swift
//  MovieTracker
//
//  Created by Aleksey on 5/14/22.
//

import Foundation

struct LoginRequest: Encodable {
	let username: String
	let password: String
	let requestToken: String
	
	enum CodingKeys: String, CodingKey {
		case username
		case password
		case requestToken = "request_token"
	}
}

//TODO: - does it make sense to reuse TokenResponse since it has matching structure
struct LoginResponse: Decodable {
	let success: Bool
	let expiresAt: String
	let requestToken: String
	
	enum CodingKeys: String, CodingKey {
		case success
		case expiresAt = "expires_at"
		case requestToken = "request_token"
	}
}
