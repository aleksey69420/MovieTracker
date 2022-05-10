//
//  TabBarVC.swift
//  MovieTracker
//
//  Created by Aleksey on 5/5/22.
//

import UIKit

class TabBarVC: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [createHomeNC(), createTVShowsNC(), createMoviesNC(), createPeopleNC()]
	}
	
	
	//MARK: - Configure TabBar
	private func createHomeNC() -> UINavigationController {
		let homeVC = HomeVC()
		homeVC.title = "Home"
		homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
		return UINavigationController(rootViewController: homeVC)
	}
	
	
	private func createTVShowsNC() -> UINavigationController {
		let tvShowsVC = TVShowsVC()
		tvShowsVC.title = "TV Shows"
		tvShowsVC.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "star.fill"), tag: 1)
		return UINavigationController(rootViewController: tvShowsVC)
	}
	
	
	private func createMoviesNC() -> UINavigationController {
		let moviesVC = MoviesVC()
		moviesVC.title = "Movies"
		moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "list.and.film"), tag: 2)
		return UINavigationController(rootViewController: moviesVC)
	}
	
	
	private func createPeopleNC() -> UINavigationController {
		let peopleVC = PeopleVC()
		peopleVC.title = "People"
		peopleVC.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person.3.fill"), tag: 3)
		return UINavigationController(rootViewController: peopleVC)
	}
}

