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
		
		
		//TODO: - review access control
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
	
	
		
	func getRequestToken(handler: @escaping (Result<TokenResponse, Error>) -> Void) {
		let url = EndPoint.getRequestToken.url
		getRequest(for: url, responseType: TokenResponse.self) { result in
			switch result {
			case .success(let response):
				self.requestToken = response.requestToken
				handler(.success(response))
			case .failure(let error):
				print("error parsing the request token \(error.localizedDescription)")
				handler(.failure(error))
			}
		}
	}
	
	
	
	//MARK: Private
	
	private func getRequest<ResponseType: Decodable>(for url: URL, responseType: ResponseType.Type, then handler: @escaping (Result<ResponseType, Error>) -> Void) {
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
			//TODO: - check the response code
			
			guard let data = data, error == nil else {
				handler(.failure(error!))
				return
			}
			
			do {
				let response = try JSONDecoder().decode(ResponseType.self, from: data)
				print("\(#function) - \(response)")
				handler(.success(response))
			} catch {
				handler(.failure(error))
			}
		}
		task.resume()
	}
}
