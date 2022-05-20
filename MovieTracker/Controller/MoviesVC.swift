//
//  MoviesVC.swift
//  MovieTracker
//
//  Created by Aleksey on 5/9/22.
//

import UIKit

class MoviesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		
		MDBManager.shared.getFavoriteMovies { result in
			switch result {
			case .success(_):
				Log.info("Favorites Movies arrived")
			case .failure(let error):
				Log.error("Favorite Movies Error - \(error)")
			}
		}
    }
}
