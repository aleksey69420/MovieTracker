//
//  MDBManager.swift
//  MovieTracker
//
//  Created by Aleksey on 5/13/22.
//

import Foundation

class MDBManager {
	
	static let shared = MDBManager()
	private init() { }
	
	static private let api_key = "64220f6c5aefcbcea6bded475e131e43"
	
	private var requestToken = ""
	
	
	enum EndPoint {
		case getRequestToken
		
		static let baseUrl = "https://api.themoviedb.org/3"
		static let apiKeyParameter = "?api_key=\(MDBManager.api_key)"
		
		
		var stringURL: String {
			switch self {
			case .getRequestToken:
				return EndPoint.baseUrl + "/authentication/token/new" + EndPoint.apiKeyParameter
			}
		}
		
		var url: URL {
			return URL(string: stringURL)!
		}
	}
	
	
	func getRequestToken(completion: @escaping (Result<Bool, Error>) -> Void) {
		let task = URLSession.shared.dataTask(with: EndPoint.getRequestToken.url) { data, response, error in
			
			//TODO: - response status 400 (doc example) has different reponse json structure
			guard let data = data, error == nil else {
				completion(.failure(error!))
				return
			}

			do {
				let response = try JSONDecoder().decode(TokenResponse.self, from: data)
				print("\(#function) - \(response)")
				self.requestToken = response.requestToken
				completion(.success(true))
			} catch {
				print("Error parsing the request token \(error.localizedDescription)")
				completion(.failure(error))
			}
		}
		task.resume()
	}
}
