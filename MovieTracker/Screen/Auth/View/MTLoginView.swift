//
//  MTLoginView.swift
//  MovieTracker
//
//  Created by Aleksey on 5/8/22.
//

import UIKit

class MTLoginView: UIView {

	private let stackView = UIStackView()
	private let usernameTextField = MTTextField(placeholder: "Username")
	private let dividerView = UIView()
	private let passwordTextField = MTTextField(placeholder: "Password", isSecure: true)
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = 5
		clipsToBounds = true
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 9
		
		
		stackView.addArrangedSubview(usernameTextField)
		stackView.addArrangedSubview(dividerView)
		stackView.addArrangedSubview(passwordTextField)
		
		addSubview(stackView)
		
		dividerView.translatesAutoresizingMaskIntoConstraints = false
		dividerView.backgroundColor = .secondarySystemFill
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 2),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 2),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			
			dividerView.heightAnchor.constraint(equalToConstant: 1)
		])
	}
}
