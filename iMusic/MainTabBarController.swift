//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Akan Akysh on 1/28/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchIcon = UIImage(systemName: "magnifyingglass")
        let musicLibraryIcon = UIImage(named: "musicLibrary")
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: SearchViewController(), image: searchIcon!, title: "Search"),
            generateViewController(rootViewController: ViewController(), image: musicLibraryIcon!, title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
}
