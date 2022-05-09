//
//  LoginVC.swift
//  MovieTracker
//
//  Created by Aleksey on 5/8/22.
//

import UIKit

class LoginVC: UIViewController {
	
	let loginView = MTLoginView()
	let signInButton = MTButton()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureUI()
	}
	
	
	private func configureUI() {
		view.backgroundColor = .systemBackground
		
		view.addSubview(loginView)
		view.addSubview(signInButton)
		
		let padding: CGFloat = 16
		
		NSLayoutConstraint.activate([
			loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
			signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 40),
			signInButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
