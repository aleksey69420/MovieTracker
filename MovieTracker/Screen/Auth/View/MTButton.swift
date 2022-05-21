//
//  MTButton.swift
//  MovieTracker
//
//  Created by Aleksey on 5/8/22.
//

import UIKit

class MTButton: UIButton {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .systemBlue
		layer.cornerRadius = 10
		setTitle("Sign In", for: .normal)
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
	}
}
