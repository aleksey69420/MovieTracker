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
	private var sessionId: String? {
		return UserDefaults.standard.string(forKey: "sessionId")
	}

	
	var isSigned: Bool {
		sessionId != nil
	}
	
	
	enum EndPoint {
		case getRequestToken
		case authorizeTokenWithCredentials
		case createSession
		case logout
		
		
		//TODO: - review access control
		static let baseUrl = "https://api.themoviedb.org/3"
		static let apiKeyParameter = "?api_key=\(MDBManager.api_key)"
		
		
		var stringURL: String {
			switch self {
			case .getRequestToken:
				return EndPoint.baseUrl + "/authentication/token/new" + EndPoint.apiKeyParameter
			case .authorizeTokenWithCredentials:
				return EndPoint.baseUrl + "/authentication/token/validate_with_login" + EndPoint.apiKeyParameter
			case .createSession:
				return EndPoint.baseUrl + "/authentication/session/new" + EndPoint.apiKeyParameter
			case .logout:
				return EndPoint.baseUrl + "/authentication/session" + EndPoint.apiKeyParameter
			}
		}
		
		
		var url: URL {
			return URL(string: stringURL)!
		}
	}
	
	
	func login(with username: String, and password: String, then handler: @escaping (Result<Bool, Error>) -> Void) {
		
		getRequestToken { result in
			switch result {
			case .success(let tokenResponse):
				self.authorize(token: tokenResponse.requestToken, with: username, and: password) { result in
					switch result {
					case .success(let loginResponse):
						self.createSession(with: loginResponse.requestToken) { result in
							switch result {
							case .success(let sessionResponse):
								UserDefaults.standard.setValue(sessionResponse.sessionId, forKey: "sessionId")
								DispatchQueue.main.async { handler(.success(true)) }
							case .failure(let error):
								DispatchQueue.main.async { handler(.failure(error)) }
							}
						}
					case .failure(let error):
						DispatchQueue.main.async { handler(.failure(error)) }
					}
				}
			case .failure(let error):
				DispatchQueue.main.async { handler(.failure(error)) }
			}
		}
	}
	
	
	func logout() {
		
		let url = EndPoint.logout.url
		var request = URLRequest(url: url)
		request.httpMethod = "DELETE"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = try! JSONEncoder().encode(SessionRemoveRequest(sessionId: sessionId!))
		
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else { return }
			
			do {
				let response = try JSONDecoder().decode(SessionRemoveResponse.self, from: data)
				//currently not handling "false" logout result - is required since no error above?
				Log.info("JSON Decoded - \(response.success)")
				DispatchQueue.main.async {
					self.requestToken = ""
					UserDefaults.standard.removeObject(forKey: "sessionId")
					NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
				}
			} catch {
				Log.error("Parsing JSON error")
			}
		}
		task.resume()
	}
	
	
	//MARK: Private
	
	private func getRequestToken(handler: @escaping (Result<TokenResponse, Error>) -> Void) {
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
	
	
	private func authorize(token: String, with username: String, and password: String, then handler: @escaping (Result<LoginResponse, Error>) -> Void) {
		//get the token authorization
		//create the session
		
		var request = URLRequest(url: EndPoint.authorizeTokenWithCredentials.url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = try! JSONEncoder().encode(LoginRequest(username: username, password: password, requestToken: token))
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				handler(.failure(error!))
				return
			}
			
			do {
				let result = try JSONDecoder().decode(LoginResponse.self, from: data)
				Log.info("JSON Decoded into: \(result)")
				handler(.success(result))
			} catch {
				Log.error("Parsing JSON error")
				handler(.failure(error))
			}
		}
		task.resume()
	}
	
	
	private func createSession(with requestToken: String, then  handler: @escaping (Result<SessionResponse, Error>) -> Void) {
		
		var request = URLRequest(url: EndPoint.createSession.url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		// changing the approach by passing token from previous get requst
		request.httpBody = try! JSONEncoder().encode(SessionRequest(requestToken: requestToken))
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				handler(.failure(error!))
				return
			}
			
			do {
				let result = try JSONDecoder().decode(SessionResponse.self, from: data)
				Log.info("JSON Decoded into: \(result)")
				// save with user defaults
				//UserDefaults.standard.setValue(result.sessionId, forKey: "sessionId")
				//self.sessionId = result.sessionId
				handler(.success(result))
			} catch {
				handler(.failure(error))
			}
		}
		task.resume()
	}
	
	
	//MARK: - Generic GET/POST requests
	
	//TODO: - create generic post request
	
	private func getRequest<ResponseType: Decodable>(for url: URL, responseType: ResponseType.Type, then handler: @escaping (Result<ResponseType, Error>) -> Void) {
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			
			//TODO: - check the response code
			
			guard let data = data, error == nil else {
				handler(.failure(error!))
				return
			}
			
			do {
				let response = try JSONDecoder().decode(ResponseType.self, from: data)
				Log.info("JSON Decoded into: \(response)")
				handler(.success(response))
			} catch {
				handler(.failure(error))
			}
		}
		task.resume()
	}
}
