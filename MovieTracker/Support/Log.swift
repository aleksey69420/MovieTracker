//
//  Log.swift
//  MovieTracker
//
//  Created by Aleksey on 5/15/22.
//

import Foundation


enum Log {
	
	enum LogLevel {
		case info
		case warning
		case error
		
		fileprivate var prefix: String {
			switch self {
			case .info: return "INFO ✅"
			case .warning: return "WARNING ⚠️"
			case .error: return "ALERT ❌"
			}
		}
	}
	
	
	struct Context {
		let file: String
		let function: String
		let line: Int
		
		var description: String {
			return "\((file as NSString).lastPathComponent):\(line) \(function)"
		}
	}
	
	// Static function for each LogLevel case
	
	static func info(_ message: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .info, message: message, shouldLogContext: shouldLogContext, context: context)
	}
	
	
	static func warning(_ message: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .warning, message: message, shouldLogContext: shouldLogContext, context: context)
	}
	
	
	static func error(_ message: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .error, message: message, shouldLogContext: shouldLogContext, context: context)
	}
	
	
	//MARK: - Private
	fileprivate static func handleLog(level: LogLevel, message: String, shouldLogContext: Bool, context: Context) {
		
		let logComponents = ["[\(level.prefix)]", message]
		
		var fullString = logComponents.joined(separator: " ")
		
		if shouldLogContext {
			fullString += " ➜ \(context.description)"
		}
		
		#if DEBUG
		print(fullString)
		#endif
	}
}
