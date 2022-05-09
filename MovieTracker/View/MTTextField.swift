//
//  MTTextField.swift
//  MovieTracker
//
//  Created by Aleksey on 5/8/22.
//

import UIKit

class MTTextField: UITextField {
	
	private var toggleButton: UIButton?
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	convenience init(placeholder: String, isSecure: Bool = false) {
		self.init(frame: .zero)
		self.placeholder = placeholder
		self.isSecureTextEntry = isSecure
		configure()
	}
	
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .label
		tintColor = .label
		textAlignment = .left
		font = UIFont.preferredFont(forTextStyle: .title3)
		
		autocorrectionType = .no
		returnKeyType = .next
		
		
		if isSecureTextEntry {
			
			toggleButton = UIButton()
			toggleButton?.setImage(UIImage(systemName: "eye.fill"), for: .normal)
			toggleButton?.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
			
			rightView = toggleButton
			rightViewMode = .always
			
			toggleButton?.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		}
	}
	
	
	@objc private func togglePasswordView() {
		isSecureTextEntry.toggle()
		toggleButton?.isSelected.toggle()
	}
}
