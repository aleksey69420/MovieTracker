//
//  AppDelegate.swift
//  MovieTracker
//
//  Created by Aleksey on 5/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		setRootVC()
		window?.makeKeyAndVisible()
		return true
	}
	
	
	private func setRootVC() {
		//TODO: Move isSingedIn to the LocalState
		//TODO: Add animation
		if MDBManager.shared.isSigned {
			window?.rootViewController = TabBarVC()
		} else {
			window?.rootViewController = LoginVC()
		}
	}
}

